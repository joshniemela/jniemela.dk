<script lang="ts">
	// date is a tuple of [start, end], just [start] if there is no end or [] if there is no date
	export let date: string[] = [];

	function formatFromTo(date: string[]): string {
		if (date.length === 0) return '';
		if (date.length === 1) return `${date[0]} ⟶`;
		return `${date[0]} - ${date[1]}`;
	}
</script>

<div class="pb-4 pt-2">
	<div class="flex justify-between font-bold -mb-0.5">
		<slot name="title" />
		<p>{formatFromTo(date)}</p>
	</div>
	<div class="border-t-2 border-l-2 pl-3 border-purple-900">
		<slot />
	</div>
</div>
