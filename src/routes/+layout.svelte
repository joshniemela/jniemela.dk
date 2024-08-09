<script lang="ts">
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
