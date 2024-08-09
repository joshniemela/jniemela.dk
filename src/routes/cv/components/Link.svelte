<script lang="ts">
	export let link: string;
	export let text: string;
	export let icon: string | undefined = undefined;
	// export a class for tailwindcss
	let style: string | undefined = undefined;
	export { style as class };
</script>

<a href={link} class="flex items-center space-x-1 text-purple-900 hover:text-purple-400">
	{#if icon}
		<img src={icon} alt={text} class="w-5 h-5" />
	{/if}
	<span class={style}>{text}</span>
</a>
