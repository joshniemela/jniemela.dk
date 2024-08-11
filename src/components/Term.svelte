<script lang="ts">
	import '@xterm/xterm/css/xterm.css';
	import { onMount } from 'svelte';

	let term: HTMLElement;
	let { options } = $props();

	onMount(async () => {
		const { Terminal } = await import('@xterm/xterm');
		const terminal = new Terminal(options);

		terminal.open(term);

		terminal.onData((data) => {
			console.log(data);
		});
	});
</script>

<div bind:this={term}></div>
