import { spawn } from 'node:child_process';
import type { ChildProcess } from 'node:child_process';
import net from 'node:net';

// Map of string to Process, one userid gets one game
export const games: Map<string, Hs2048Game> = new Map();

enum ServerState {
	WAITING,
	IDLE,
	STOPPED
}

export class Hs2048Game {
	#server: net.Server;
	#process?: ChildProcess;
	#currentState: string = '';
	#serverState: ServerState = ServerState.STOPPED;
	constructor() {
		this.#server = net.createServer((socket) => {
			console.log('Client connected');
			socket.on('data', (data) => {
				this.#currentState = data.toString();
				// The first data we receive we can assume means it's started
				if (this.#serverState === ServerState.WAITING) {
					this.#serverState = ServerState.IDLE;
				}
			});
			socket.on('close', () => {
				console.log('Client disconnected');
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
			console.log(`TCP server started on port ${this.#server.address().port}`);
		});
		this.#process = spawn('./src/routes/projects/hs2048/hs2048', [
			'-p',
			this.#server.address().port.toString()
		]);
		// Wait for the server to start
		while (this.#serverState === ServerState.WAITING) {
			await new Promise((resolve) => setTimeout(resolve, 100));
		}
	}

	getState(): string {
		return this.#currentState;
	}

	async move(direction: string): Promise<void> {
		this.#process?.stdin.write(direction);
		this.#serverState = ServerState.WAITING;
		// Wait for the server to respond
		while (this.#serverState === ServerState.WAITING) {
			await new Promise((resolve) => setTimeout(resolve, 100));
		}
	}

	stop(): void {
		this.#server.close();
		this.#process?.kill();
		this.#serverState = ServerState.STOPPED;
	}
}
