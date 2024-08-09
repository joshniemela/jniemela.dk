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
						name: 'child1.1'
					},
					{
						name: 'child1.2',
						children: [
							{
								name: 'child1.2.1'
							},
							{
								name: 'child1.2.2'
							}
						]
					}
				]
			},
			{
				name: 'child2',
				children: [
					{
						name: 'child2.1'
					},
					{
						name: 'child2.2'
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
	<NavNode {tree} {activePath} depth={0} />
</nav>

<style>
</style>
