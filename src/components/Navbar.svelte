<script lang="ts">
	import NavNode from './NavNode.svelte';
	import { createActivePath } from '$lib/activePath.svelte.ts';

	let { tree } = $props<Node>();
	const activePath = createActivePath('/');
</script>

<nav>
	<NavNode {tree} remainingPath={activePath} />
</nav>
