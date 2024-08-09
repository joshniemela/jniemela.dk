<script lang="ts">
	import NavNode from './NavNode.svelte';
	import { page } from '$app/stores';

	const tree = {
		name: 'root',
		children: [
			{ name: 'home', pathAlias: '/' },
			{ name: 'about' },
			{ name: 'contact' },
			{ name: 'cv' },
			{ name: 'projects' }
		]
	};

	let activePath = $state([]);

	$effect(() => {
		activePath = $page.url.pathname.split('/');
	});
</script>

<nav>
	<NavNode {tree} {activePath} depth={0} />
</nav>

<style>
</style>
