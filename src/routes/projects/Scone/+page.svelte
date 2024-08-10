<script lang="ts">
	import Project from '../../../components/Project.svelte';
</script>

<Project
	title="Scone"
	description="An attempt to make a wackier LaTeX using Lisp"
	languagesUsed="Haskell, Scone"
	github="https://github.com/joshniemela/Scone"
	lastUpdated="29-03-2023"
>
	<p>
		As any academic knows, LaTeX is a complete hell to work with. It's written to be memory
		efficient and with incredibly powerful macros, but this comes at the cost of being a complete
		pain to work with both in terms of speed and syntax.
	</p>
	<p>
		In comes my odd little experiment, Scone. It is a lisp-like language (inspired by Scheme) that
		compiles to LaTeX, it doesn't utilise macros but instead has F-exprs. F-exprs are essentially
		first-class macros where you have functions that unevaluated code and return unevaluated code.
		This is a more powerful system than macros but comes with the downside of making static analysis
		and compilation essentially impossible. Scone has support for library files, functions,
		recursion and other features that allow it to be a complete language. Due to time-constraints
		and <a href="https://typst.app/"> Typst </a> slowly becoming more viable as a compilation target,
		I have postponed development on Scone for the time being.
	</p>
</Project>
