<script lang="ts">
	type Props = {
		tree: Node;
		activePath: string;
	};

	let { tree, remainingPath } = $props<Props>();
</script>

<ul>
	{#each tree.children as node}
		<li>
			{#if node.name === remainingPath[0]}
				<p class:active={remainingPath.length === 1}>{node.name}</p>
				{#if remainingPath.length > 1}
					<svelte:self tree={node} activePath={remainingPath.slice(1)} />
				{/if}
			{:else}
				<p>{node.name}</p>
			{/if}
		</li>
	{/each}
</ul>

<style>
	.active {
		font-weight: bold;
	}
</style>
