<script lang="ts">
	import Navbar from '../components/Navbar.svelte';

	const tree = {
		name: 'root',
		children: [
			{
				name: 'child1',
				children: [
					{
						name: 'child1.1',
						children: []
					},
					{
						name: 'child1.2',
						children: []
					}
				]
			},
			{
				name: 'child2',
				children: [
					{
						name: 'child2.1',
						children: []
					},
					{
						name: 'child2.2',
						children: []
					}
				]
			}
		]
	};
</script>

<Navbar {tree} remainingPath={[]} />

<slot />

<footer>
	<p>
		Site built using
		<a href="https://kit.svelte.dev/">SvelteKit</a>.
	</p>
</footer>
