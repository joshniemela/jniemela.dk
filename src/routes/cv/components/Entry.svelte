<script lang="ts">
	// date is a tuple of [start, end], just [start] if there is no end or [] if there is no date
	interface Props {
		date?: string[];
		title: import('svelte').Snippet;
		children?: import('svelte').Snippet;
	}

	let { date = [], title, children }: Props = $props();

	function formatFromTo(date: string[]): string {
		if (date.length === 0) return '';
		if (date.length === 1) return `${date[0]} ⟶`;
		return `${date[0]} - ${date[1]}`;
	}
</script>

<div class="pb-4 pt-2">
	<div id="row" class="flex justify-between font-bold">
		<div>
			{@render title()}
		</div>
		<p id="date">{formatFromTo(date)}</p>
	</div>
	<div class="border-t-2 border-l-2 pl-3 border-purple-900">
		{@render children?.()}
	</div>
</div>

<style>
	#row {
		font-family: 'gemunu libre';
		font-size: 1.1rem;
	}

	#date {
		font-size: 0.8rem;
		margin-top: auto;
		margin-bottom: auto;
	}
</style>
