<script lang="ts">
	import '../app.css';
	import Navbar from '../components/Navbar.svelte';
</script>

<Navbar />

<slot />

<footer>
	<p>
		Site built using
		<a href="https://kit.svelte.dev/">SvelteKit</a>.
	</p>
</footer>

<style>
	:root {
		background-color: #0a0a0a;
		font-family: 'Courier New', monospace;
		font-weight: 500;
		--colour-orange: #d16328;
		--colour-purple: #402f65;
		--colour-grey: #3c3c3c;
		--colour-light-grey: #7b7b7b;
		color: var(--colour-light-grey);
	}
</style>
