<script lang="ts">
	import type { LinkNode } from '$lib/types';
	import { page } from '$app/stores';

	const tree: LinkNode = {
		name: 'root',
		children: [
			{ name: 'home' },
			{ name: 'about' },
			{ name: 'contact' },
			{
				name: 'projects',
				children: [
					{ name: 'KU Courses' },
					{ name: 'This page' },
					{ name: 'Scone' },
					{ name: 'hs2048' }
				]
			},
			{ name: 'cv' }
		]
	};

	function flattenActiveTree(tree: LinkNode, activePath: string[]): string[][] {
		function childNames(node: LinkNode): string[] {
			return node.children ? node.children.map((child) => child.name) : [];
		}
		let activeNode: LinkNode | undefined = tree;
		let result = [];
		for (let i = 0; i < activePath.length; i++) {
			if (activeNode?.children) {
				result.push(childNames(activeNode));
				activeNode = activeNode.children.find((child) => child.name === activePath[i + 1]);
			}
		}
		return result;
	}

	let activePath: string[] = $state(['']);

	$effect(() => {
		// replace %20 with space, this is so that activePath works with pages that contain spaces
		activePath = $page.url.pathname.replace(/%20/g, ' ').split('/');
	});
</script>

{#snippet prompt(path: string, command: string, cursor = false)}
	<div class="prompt">
		<div>
			[<span style="color:var(--colour-purple)">user@jniemela.dk</span>:
			<span style="color: var(--colour-orange)">{path}</span>]$ {command}
		</div>

		{#if cursor}
			<div id="cursor"></div>
		{/if}
	</div>
{/snippet}

<nav>
	{@render prompt('/', 'ls')}
	<ul>
		{#each flattenActiveTree(tree, activePath) as layer, i}
			<li>
				{#each layer as nodeName}
					{#if nodeName === 'home'}
						{#if activePath[1] === ''}
							<a class="active" href="/">{nodeName}</a>
						{:else}
							<a href="/">{nodeName}</a>
						{/if}
					{:else if nodeName === activePath[i + 1]}
						<a class="active" href="{activePath.slice(0, i + 1).join('/')}/{nodeName}"
							>{nodeName}
						</a>
					{:else}
						<a href="{activePath.slice(0, i + 1).join('/')}/{nodeName}">{nodeName}</a>
					{/if}
				{/each}
			</li>
		{/each}
	</ul>
	{@render prompt(activePath.join('/'), '', true)}
</nav>

<style>
	nav {
		display: flex;
		flex-direction: column;
		border-bottom: 0.2em solid var(--colour-grey);
	}
	nav a.active {
		color: var(--colour-orange);
	}

	nav a {
		padding: 0.1em;
		margin: 0.3em;
		color: var(--colour-light-grey);
	}

	nav a:hover {
		background-color: var(--colour-grey);
		color: white;
	}

	#cursor {
		width: 0.6em;
		border: 0.1em solid var(--colour-grey);
		background-color: var(--colour-grey);
		animation: blink 2s step-end infinite;
		float: left;
		margin-left: 0.4em;
		margin-top: 0.18em;
		margin-bottom: 0.25em;
	}
	@keyframes blink {
		50% {
			background-color: transparent;
		}
	}

	.prompt {
		display: flex;
		color: var(--colour-grey);
	}
	ul {
		padding: 0 1em;
	}
</style>
