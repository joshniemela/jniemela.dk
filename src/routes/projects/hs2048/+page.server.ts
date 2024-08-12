import { v4 as uuid } from 'uuid';
import { Hs2048Game } from '$lib/hs2048';
import { spawn } from 'child_process';

export function load({ cookies }) {
	let userId = cookies.get('uuid');
	if (!userId) {
		userId = uuid();
		cookies.set('uuid', userId, { path: '/' });
	}
	return { userId };
}

const game = new Hs2048Game();

console.log('Starting game');
await game.start();

console.log('Game started');
console.log('Game state:', game.getState());

for (let i = 0; i < 10; i++) {
	console.log('Moving random direction');
	await game.move(['w', 'a', 's', 'd'][Math.floor(Math.random() * 4)]);
	console.log('Game state:', game.getState());
}
