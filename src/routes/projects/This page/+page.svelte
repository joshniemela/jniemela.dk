<script lang="ts">
	import Project from '../../../components/Project.svelte';
</script>

<Project
	title="This page"
	description="My personal website"
	languagesUsed="Svelte"
	github="https://github.com/joshniemela/v2.jniemela.dk"
	lastUpdated="09-08-2024"
>
	<div class="wrapper">
		<iframe src="http://localhost:5173" title="My personal page" class="frame"></iframe>
	</div>
	<p>
		Slightly meta, but this is the page you're currently on. It's a website built with SvelteKit.
		The most notable feature of this website is the navbar which is able to recurse arbitrarily deep
		into the page structure.
	</p>
	<p>
		Another interesting feature is that my CV is acutally not a PDF but a HTML page. This makes it
		responsive so it works on all devices and it loads smoothly without needing a PDF reader on the
		browser. It also has CSS media queries to make it possible to print it as an ordinary
		black-on-white PDF.
	</p>
</Project>

<style>
	ul {
		list-style-type: square;
		margin-left: 20px;
	}

	.frame {
		border: 0;

		width: 100%;
		height: 40em;

		background-color: white;
	}
	.wrapper {
		display: flex;
		justify-content: center;
		margin-bottom: 1em;
		border: 2px solid var(--colour-orange);
	}
</style>
