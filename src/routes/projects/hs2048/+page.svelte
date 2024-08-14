<script lang="ts">
	import Project from '../../../components/Project.svelte';
	import Term from '../../../components/Term.svelte';
</script>

<Project
	title="hs2048"
	description="A 2048 clone written in Haskell"
	languagesUsed="Haskell"
	github="https://github.com/joshniemela/hs2048"
	lastUpdated="21-11-2022"
>
	<p>
		In our introductory couse on programming, we had to code a 3x3 version of 2048 in F#, without
		numbers and without being allowed to use matrices. I found this very frustrating and decided to
		learn Haskell in a week and code a more complete version of 2048 in Haskell. This was my first
		real project in Haskell, and I later on added a TCP server to it to allow other programs to
		interact with the game.
	</p>
	<p>
		At the time that I wrote this, I didn't know how to write stateful code in Haskell and therefore
		the game is acutally stateless, the score is a heuristic based on the current board state, a
		funny consequence of this is that the blocks are internally represented by their logarithm to
		the base 2, and the score is calculated by the following function:
	</p>
	<div class="sourceCode" id="cb1">
		<pre class="sourceCode haskell"><code class="sourceCode haskell"
				><span id="cb1-1"
					><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="ot"
						>recurrentScore ::</span
					> <span class="dt">Maybe</span> <span class="dt">Int</span> <span class="ot">-&gt;</span
					> <span class="dt">Int</span></span
				>
<span id="cb1-2"
					><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>recurrentScore <span class="dt"
						>Nothing</span
					> <span class="ot">=</span> <span class="dv">0</span></span
				>
<span id="cb1-3"
					><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a><span class="co"
						>-- The additional term is to account for the randomly spawned 4s</span
					></span
				>
<span id="cb1-4"
					><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a>recurrentScore (<span class="dt"
						>Just</span
					> n) <span class="ot">=</span> <span class="dv">2</span> <span class="op">^</span> n <span
						class="op">*</span
					> (n <span class="op">-</span> <span class="dv">1</span>) <span class="op">-</span> <span
						class="fu">quot</span
					> (<span class="dv">2</span> <span class="op">^</span> (n <span class="op">+</span> <span
						class="dv">1</span
					>)) <span class="dv">11</span></span
				>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-6"
					><a href="#cb1-6" aria-hidden="true" tabindex="-1"></a><span class="co"
						>-- map recurrentScore to each element of the grid and sum the result</span
					></span
				>
<span id="cb1-7"
					><a href="#cb1-7" aria-hidden="true" tabindex="-1"></a><span class="ot">scoreGrid ::</span
					> <span class="dt">Grid</span> <span class="ot">-&gt;</span> <span class="dt">Int</span
					></span
				>
<span id="cb1-8"
					><a href="#cb1-8" aria-hidden="true" tabindex="-1"></a>scoreGrid grid <span class="ot"
						>=</span
					> <span class="fu">sum</span> <span class="op">$</span> <span class="fu">map</span> (<span
						class="fu">sum</span
					> <span class="op">.</span> <span class="fu">map</span> recurrentScore) grid</span
				></code
			></pre>
	</div>
	<p>
		This function gives an approximately correct score at any given time without saving the state.
		The game will be embedded into this page at a later time.
	</p>
	<Term options={{ convertEol: true, rows: 11 }} />
</Project>
