<script lang="ts">
	import '@xterm/xterm/css/xterm.css';
	import { onMount } from 'svelte';
	import type { Board } from '$lib/hs2048';

	let term: HTMLElement;
	let { options } = $props();
	/*
import GameLogic (Grid, Tile)

-- This function calculates the approximate score of the game using the recurrence relation:
-- a_n = 2a_{n-1}+2^n
-- This is solved for the full equation and the randomly spawned 4s are acconted for with
-- the last term of recurrentScore
recurrentScore :: Maybe Int -> Int
recurrentScore Nothing = 0
-- The additional term is to account for the randomly spawned 4s
recurrentScore (Just n) = 2 ^ n * (n - 1) - quot (2 ^ (n + 1)) 11

-- map recurrentScore to each element of the grid and sum the result
scoreGrid :: Grid -> Int
scoreGrid grid = sum $ map (sum . map recurrentScore) grid

-- Display the 4x4 grid in the terminal
displayGrid :: Grid -> IO ()
displayGrid grid =
           "┌────┬────┬────┬────┐\n"
        ++ "│"
        ++ intercalate "│" (map displayTile (grid !! 0))
        ++ "│\n"
        ++ "├────┼────┼────┼────┤\n"
        ++ "│"
        ++ intercalate "│" (map displayTile (grid !! 1))
        ++ "│\n"
        ++ "├────┼────┼────┼────┤\n"
        ++ "│"
        ++ intercalate "│" (map displayTile (grid !! 2))
        ++ "│\n"
        ++ "├────┼────┼────┼────┤\n"
        ++ "│"
        ++ intercalate "│" (map displayTile (grid !! 3))
        ++ "│\n"
        ++ "└────┴────┴────┴────┘\n"
        ++ "Score: "
        ++ show (scoreGrid grid)
        & putStrLn
  where
    -- Display a single tile
    displayTile :: Tile -> String
    displayTile Nothing = "    "
    -- Convert the log2 representation of a tile to normal linear space
    displayTile (Just n) = show (2 ^ n :: Int) ++ "   " & take 4

clearScreen :: IO ()
clearScreen = putStr "\ESC[2J" -- ANSI code for wiping the entire screen
*/
	// Copy this haskell code

	function renderBoard(board: Board) {
		// Board is "score": int and "board": int[][]
		if (board.score === null) {
			console.log('Game over');
			return 'Game over!\n';
		}
		let output = '\x1b[2J';
		output += '┌────┬────┬────┬────┐\n';
		for (let i = 0; i < 4; i++) {
			output += '│';
			for (let j = 0; j < 4; j++) {
				output += board.board[i][j] === 0 ? '    ' : board.board[i][j].toString().padEnd(4);
				output += '│';
			}
			output += '\n';
			if (i !== 3) {
				output += '├────┼────┼────┼────┤\n';
			}
		}
		output += '└────┴────┴────┴────┘\n';
		output += `Score: ${board.score}\n`;
		return output;
	}

	onMount(async () => {
		const { Terminal } = await import('@xterm/xterm');
		const terminal = new Terminal(options);

		terminal.open(term);

		fetch('/api/hs2048', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: '{}'
		})
			.then((response) => response.text())
			.then((data) => terminal.write(renderBoard(JSON.parse(data))));

		terminal.onData((data) => {
			// if its either wasdq then send it to the server
			if (['w', 'a', 's', 'd', 'q'].includes(data)) {
				fetch('/api/hs2048', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ direction: data })
				})
					.then((response) => response.text())
					.then((data) => terminal.write(renderBoard(JSON.parse(data))));
			}
		});
	});
</script>

<div bind:this={term}></div>
