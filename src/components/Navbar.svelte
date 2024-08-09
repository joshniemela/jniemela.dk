<script lang="ts">
	import NavNode from './NavNode.svelte';
	import { page } from '$app/stores';

	const tree = {
		name: 'root',
		children: [
			{ name: 'home', pathAlias: '/' },
			{ name: 'about' },
			{ name: 'contact' },
			{
				name: 'projects',
				children: [
					{ name: 'hs2048' },
					{ name: 'This page' },
					{ name: 'Scone' },
					{ name: 'KU Courses' }
				]
			},
			{ name: 'cv' }
		]
	};

	let activePath = $state([]);

	$effect(() => {
		// replace %20 with space, this is so that activePath works with pages that contain spaces
		activePath = $page.url.pathname.replace(/%20/g, ' ').split('/');
	});
</script>

<nav>
	<NavNode {tree} {activePath} depth={0} />
</nav>

<style>
</style>
