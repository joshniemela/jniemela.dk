<script lang="ts">
	type Props = {
		tree: Node;
		activePath: string;
		depth: number;
	};

	let { tree, activePath, depth } = $props<Props>();
</script>

<ul>
	{#if tree.children}
		{#each tree.children as node}
			<li>
				{#if node.pathAlias}
					{#if node.pathAlias === activePath.join('/')}
						<a class="active" href={node.pathAlias}>{node.name}</a>
					{:else}
						<a href={node.pathAlias}>{node.name}</a>
					{/if}
				{:else if node.name === activePath[depth + 1]}
					<a class="active" href="{activePath.slice(0, depth + 1).join('/')}/{node.name}"
						>{node.name}
					</a>
					<svelte:self tree={node} {activePath} depth={depth + 1} />
				{:else}
					<a href="{activePath.slice(0, depth + 1).join('/')}/{node.name}">{node.name}</a>
				{/if}
			</li>
		{/each}
	{/if}
</ul>

<style>
	.active {
		font-weight: bold;
	}
</style>
