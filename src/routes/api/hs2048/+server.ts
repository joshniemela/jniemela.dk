import { json } from '@sveltejs/kit';
import { Hs2048Game } from '$lib/hs2048';

let running_games = new Map<string, Hs2048Game>();
// occasionally poll the games and delete if inactive
setInterval(() => {
	for (const [key, game] of running_games) {
		if (game.isInactive() || game.isStopped()) {
			console.log('Game inactive, stopping:', key);
			game.stop();
			running_games.delete(key);
		}
	}
}, 6000);

export async function POST({ request, cookies }) {
	// get userid from a cookie
	let userId = cookies.get('uuid');
	if (!userId) {
		throw new Error('No userid found, this should not happen');
	}
	// get the game for this user
	let game = running_games.get(userId);
	// if the game is not found, create a new game
	if (!game) {
		game = new Hs2048Game();
		running_games.set(userId, game);
		await game.start();
	}
	// get the direction from the request body
	const { direction } = await request.json();
	if (direction === null || direction === undefined) {
		return json(game.getBoard());
	}
	if (!['w', 'a', 's', 'd', 'q'].includes(direction)) {
		return json({ error: 'Invalid direction' }, { status: 400 });
	}
	console.log('Moving in direction:', direction);
	// move the game in the specified direction
	await game.move(direction);
	console.log('Game state:', game.getState());

	return json(game.getBoard());
}
