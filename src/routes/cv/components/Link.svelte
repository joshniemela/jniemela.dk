<script lang="ts">
	// export a class for tailwindcss
	interface Props {
		link: string;
		text: string;
		icon?: string | undefined;
		class?: string | undefined;
	}

	let {
		link,
		text,
		icon = undefined,
		class: style = undefined
	}: Props = $props();
	
</script>

<a href={link} class="flex items-center space-x-1 text-purple-900 hover:text-purple-400">
	{#if icon}
		<img src={icon} alt={text} class="w-5 h-5" />
	{/if}
	<span class={style}>{text}</span>
</a>
