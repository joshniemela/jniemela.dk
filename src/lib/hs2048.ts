import { spawn } from 'node:child_process';
import type { ChildProcess } from 'node:child_process';

// Map of string to Process, one userid gets one game
export const games: Map<string, ChildProcess> = new Map();

export function restartGame(userId: string) {
	if (games.has(userId)) {
		games.get(userId)!.kill();
		games.delete(userId);
	}
	const game = spawn('./src/routes/projects/hs2048/hs2048');
	games.set(userId, game);
	return game;
}

export function move(userId: string, direction: string) {
	const game = games.get(userId);
	if (!game) return;
	game.stdin.write(direction + '\n');
}

export function getBoard(userId: string) {
	const game = games.get(userId);
	if (!game) return;
	return new Promise((resolve) => {
		game.stdout.once('data', (data) => {
			resolve(data.toString());
		});
	});
}
