<script lang="ts">
	import NavNode from './NavNode.svelte';
	import { page } from '$app/stores';

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

	let activePath = $state([]);

	$effect(() => {
		activePath = $page.url.pathname.split('/');
	});
</script>

<nav>
	<NavNode {tree} {activePath} />
</nav>

<style>
</style>
