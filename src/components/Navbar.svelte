<script lang="ts">
	import type { LinkNode } from '$lib/types';
	import NavNode from './NavNode.svelte';
	import { page } from '$app/stores';

	const tree: LinkNode = {
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

	let activePath: string[] = $state([]);

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
	<NavNode {tree} {activePath} depth={0} />
	{@render prompt(activePath.join('/'), '', true)}
</nav>

<style>
	nav {
		display: flex;
		flex-direction: column;
	}
	:global(nav a.active) {
		color: var(--colour-orange);
	}

	#cursor {
		width: 0.5em;
		height: 1em;
		border: 0.1em solid var(--colour-grey);
		background-color: var(--colour-grey);
		animation: blink 2s step-end infinite;
		float: left;
		margin-left: 0.5em;
	}
	@keyframes blink {
		50% {
			background-color: transparent;
		}
	}
</style>
