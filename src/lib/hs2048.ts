import { spawn } from 'node:child_process';
import type { ChildProcess } from 'node:child_process';
import net from 'node:net';
import { AddressInfo } from 'net';

// This should be an env var
const hs2048BinaryPath = process.env.HS2048_BINARY_PATH || 'src/lib/hs2048-binary';

// Map of string to Process, one userid gets one game
export const games: Map<string, Hs2048Game> = new Map();

enum ServerState {
	WAITING,
	IDLE,
	STOPPED
}

enum Direction {
	UP = 'w',
	DOWN = 's',
	LEFT = 'a',
	RIGHT = 'd'
}

export type Board = {
	board: number[][];
	score: number;
};

export class Hs2048Game {
	#server: net.Server;
	#process?: ChildProcess;
	#currentState: string = '';
	#serverState: ServerState = ServerState.STOPPED;
	#lastActivity: number = Date.now();
	constructor() {
		this.#server = net.createServer((socket) => {
			console.log('Client connected');
			socket.on('data', (data) => {
				console.log('Received data:', data.toString());
				this.#currentState = data.toString();
				// The first data we receive we can assume means it's started
				if (this.#serverState === ServerState.WAITING) {
					this.#serverState = ServerState.IDLE;
				}
			});
			socket.on('close', (reason) => {
				console.log('Client disconnected', reason);
			});
			socket.on('error', (err) => {
				console.error('Connection error:', err);
			});
		});
		this.#currentState = '';
	}

	async start(): Promise<void> {
		this.#serverState = ServerState.WAITING;
		this.#server.listen(0, () => {
			console.log(`TCP server started on port ${(this.#server.address() as AddressInfo).port}`);
		});
		this.#process = spawn(
			hs2048BinaryPath,
			['-p', (this.#server.address() as AddressInfo).port.toString()],
			{ stdio: ['pipe', 'ignore', 'ignore'] }
		);
		// Wait for the server to start
		while (this.#serverState === ServerState.WAITING) {
			await new Promise((resolve) => setTimeout(resolve, 100));
		}
	}

	getState(): string {
		return this.#currentState;
	}

	getBoard(): Board {
		// First number is the score, then the next 16 numbers are the 4x4 board
		const data = this.#currentState.split('\n')[0].split(' ').slice(0, 17);
		const score = parseInt(data[0]);
		const board = [];
		for (let i = 1; i < data.length; i += 4) {
			board.push(
				data.slice(i, i + 4).map((num) => {
					const n = parseInt(num);
					return n === 0 ? 0 : 2 ** n;
				})
			);
		}
		return { board, score };
	}

	isInactive(): boolean {
		// If the last activity was more than 10 minutes ago, we consider it inactive and it can be deleted
		return Date.now() - this.#lastActivity > 600000;
	}
	isStopped(): boolean {
		return this.#serverState === ServerState.STOPPED;
	}

	async move(direction: string): Promise<void> {
		console.log('Moving:', direction);
		console.log('Server state:', this.#serverState);
		if (this.#serverState === ServerState.STOPPED) {
			return;
		}
		// We can assert non-null since the server is running, this means a process was made.
		this.#process!.stdin!.write(direction);
		console.log('Sent direction:', direction);
		if (this.#currentState === 'gameover') {
			this.#serverState = ServerState.STOPPED;
			return;
		} else {
			this.#lastActivity = Date.now();
			this.#serverState = ServerState.WAITING;
		}

		// Wait for the server to respond
		let attempts = 0;
		while (this.#serverState === ServerState.WAITING && attempts < 10) {
			await new Promise((resolve) => {
				console.log('Waiting for server to respond');
				attempts++;
				setTimeout(resolve, 10);
			});
		}
		// This here exists so that the server doesn't hang forever if something weird happens
		if (attempts >= 10) {
			console.error('Server did not respond');
			this.#serverState = ServerState.IDLE;
		}
	}

	stop(): void {
		this.#server.close();
		this.#process?.kill();
		this.#serverState = ServerState.STOPPED;
	}
}
