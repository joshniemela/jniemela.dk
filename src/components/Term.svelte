<script lang="ts">
	import '@xterm/xterm/css/xterm.css';
	import { onMount } from 'svelte';
	import type { Board } from '$lib/hs2048';

	let term: HTMLElement;
	let { options } = $props();

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

<style>
	div {
		width: 12em;
		height: 100%;
		margin: 0 auto;
	}
</style>
