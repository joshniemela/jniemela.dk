<script lang="ts">
	type Props = {
		title: string;
		description: string;
		languagesUsed: string;
		github: string;
		lastUpdated: string;
	};

	let { title, description, languagesUsed, github, lastUpdated }: Props = $props();
</script>

<svelte:head>
	<title>{title}</title>
	<meta name="description" content={description} />
</svelte:head>

<main class="page">
	<h1>
		<span style="color:var(--colour-grey)">/projects/</span>{title}
	</h1>
	<p>
		Updated at: {lastUpdated}
		<a href={github} rel="noopener noreferrer">[github]</a>
	</p>
	<p>
		Language(s) used: {languagesUsed}
	</p>
	<slot />
</main>
