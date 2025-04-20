<script lang="ts">
	import Link from './components/Link.svelte';
	import Entry from './components/Entry.svelte';
	const name = 'Josh Niemelä';
	const photo_src = 'images/photo.jpg';
	const photo_class = 'sm:w-28 w-0 m-4 sm:visible invisible';
</script>

<svelte:head>
	<title>CV - {name}</title>
	<style>
		main {
			font-family: 'Inter', sans-serif;
		}

		@media print {
			main {
				height: 100%;
				width: 100%;
				position: absolute;
				top: 0;
				left: 0;
				box-shadow: none;
			}
			div {
				grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
			}
			.invisible {
				visibility: visible !important;
				width: 7rem !important;
			}
			@page {
				size: A4 portrait;
				margin: 0;
			}
			nav {
				visibility: hidden;
			}

			footer {
				display: none;
			}

			button {
				display: none;
			}

			.page-break {
				page-break-after: always;
			}
		}

		button {
			color: var(--colour-orange) !important;
		}
		button:hover {
			color: var(--colour-light-orange) !important;
		}
		/* https://excessivelyadequate.com/posts/print.html has useful info on css @page */
	</style>
</svelte:head>

<aside class="flex justify-center">
	<button
		onclick={() => {
			window.print();
		}}
	>
		Print/download PDF
	</button>
</aside>

<!--This top component contains the photo, name and contacts------------------>
<main class="text-sm p-8 m-auto shadow-lg max-w-[210mm] h-[594mm]">
	<!--Relatively position this at the left---------------------------------->
	<div class="flex items-center justify-between mb-2">
		<img src={photo_src} alt="Photo of {name}" class={photo_class} />
		<div>
			<h1 class="text-3xl font-bold text-center">
				{name}
			</h1>
			<div class="flex flex-col items-center justify-between">
				<!--Portfolio website----------------------------------------->
				<p class="text-lg">
					<Link link="https://jniemela.dk" text="jniemela.dk" class="font-semibold" />
				</p>
				<!--2x2 grid-------------------------------------------------->
				<div class="grid md:grid-cols-2 text-sm gap-2">
					<!--Email-------------------------------------------------->
					<Link link="mailto:josh@argmin.dk" text="josh@argmin.dk" />
					<!--GitHub------------------------------------------------->
					<Link
						link="https://github.com/joshniemela/"
						text="joshniemela"
						icon="images/github.svg"
					/>
					<!--Phone-------------------------------------------------->
					<Link link="tel:+4550324542" text="+45 50 32 45 42" />
					<!--LinkedIn----------------------------------------------->
					<Link
						link="https://linkedin.com/in/joshniemela"
						text="/in/joshniemela"
						icon="images/linkedin.svg"
					/>
				</div>
			</div>
		</div>
		<!--Invisible element with the same class as the photo to put the title in the middle-->
		<div class={photo_class}></div>
	</div>
	<p class="italic px-4">
		I act as an effective link between technical and non-technical stakeholders to ensure that the
		end product meets all requirements and that the project maximises organisational value. With my
		extensive knowledge in machine learning and computer science, I provide valuable insights and
		solutions to complex problems and have a more holistic view of the project than a typical
		project manager or developer.
	</p>

	<Entry>
		{#snippet title()}
			<h2 class="text-xl">Experience</h2>
		{/snippet}
		<Entry date={['2023']}>
			{#snippet title()}
				<h3>Consultant / Backend Developer</h3>
			{/snippet}
			<Entry date={['12/2024', '12/2024']}>
				{#snippet title()}
					<h3>Two Scenarios</h3>
				{/snippet}
				<ul class="list-square list-inside">
					<li>
						Completed an urgent task by developing a concurrent program within a week to retrieve
						and process pharmaceutical data from the Danish Medicines Agency (Lægemiddelstyrelsen)
						thus ensuring the customer met their critical project deadlines.
					</li>
				</ul>
			</Entry>
			<Entry date={['09/2024']}>
				{#snippet title()}
					<h3>Pingo Documents</h3>
				{/snippet}
				<ul class="list-square list-inside">
					<li>
						Performed a performance audit of a problematic part of the website, and reduced the
						number of database queries by 92% and decreased load times by more than 15x.
					</li>
					<li>
						Implemented a vector-based search algorithm to retrieve names from the EU financial
						sanctions list.
					</li>
					<li>
						Responsible for coordinating a team of five consultants, ensuring that the client's
						wishes are implemented and communicated.
					</li>
					<li>
						Designed new architecture that can be incrementally implemented to fix fundamental
						limitations in the existing codebase.
					</li>
				</ul>
			</Entry>
			<Entry date={['09/2023', '09/2024']}>
				{#snippet title()}
					<h3>AI Estate</h3>
				{/snippet}
				<ul class="list-square list-inside">
					<li>
						Worked as a contractor for Pingo Documents (working with Pingo directly after 09/2024)
						and was responsible for implementing and designing the heavier tasks, guiding and
						assisting two other developers in smaller tasks.
					</li>
					<li>
						Responsible for CI/CD, DevOps, security and ensuring the team met deadlines for client
						deliverables.
					</li>
					<li>
						Implemented major updates to UX and features, by making the frontend more responsive and
						giving it a more modern look as well as improving the previously unintuitive user flow.
					</li>
					<li>Made a service to perform information retrieval on real-estate documents.</li>
					<li>
						Performed an audit of website performance, found and fixed several problems and
						inefficiencies reducing load time by 318%.
					</li>
				</ul>
			</Entry>
			<Entry date={['06/2023', '07/2023']}>
				{#snippet title()}
					<h3>AI Estate</h3>
				{/snippet}
				<ul class="list-square list-inside">
					<li>
						Responsible for the setup of all IT infrastructure of an early stage startup (GCP,
						GitHub and CI/CD), and ensured that good programming practices were followed by the
						team.
					</li>
					<li>
						Provided consultation on the choice of technologies and architecture for the initial
						MVP.
					</li>
					<li>
						Rapidly developed an MVP in Python using FastAPI and SQLite, in three weeks, to
						interface with LLMs and other services as well as harvest relevant information from
						Tinglysning.dk.
					</li>
				</ul>
			</Entry>

			<Entry date={['01/2023', '03/2023']}>
				{#snippet title()}
					<h3>Promilist</h3>
				{/snippet}
				<ul class="list-square list-inside">
					<li>
						Migrated a Python codebase to Julia, improving readability, maintainability and
						performance.
					</li>
					<li>
						Developed code to calculate fuel-optimal paths for naval vessels, by graph-traversing
						space-time graphs on a geodesic map outperforming the existing solution in Python by 5x.
					</li>
					<li>Implemented an API in Genie.jl to interface with the existing backend.</li>
				</ul></Entry
			>
		</Entry>

		<Entry date={['08/2022', '02/2023']}>
			{#snippet title()}
				<h2>Machine Learning Developer - Juristic ApS</h2>
			{/snippet}
			<ul class="list-square list-inside">
				<li>
					Developed a program to automatically digitalise handwritten relational charts, using a
					combination of computer vision, clustering and morphological image processing in two
					months.
				</li>
				<!--
                <li>Wrote a comprehensive test suite to ensure the correctness of the program.</li>
                -->
			</ul>
		</Entry>

		<Entry date={['05/2023']}>
			{#snippet title()}
				<h2>KU Courses - Project</h2>
			{/snippet}
			<ul class="list-square list-inside">
				<li>Lead developer of a open source project with multiple contributors.</li>
				<li>
					Used SEO and grassroots marketing to increase the monthly active users from 0 to 200.
				</li>
				<li>
					Developed a <a href="https://kucourses.dk/" class="text-purple-900 hover:text-purple-400">
						event-driven microservice based SPA
					</a>
					in Typescript, Clojure and Rust which asynchronously scrape pages, stores and displays course
					information from KU's course catalogue with significant performance (3x-15x shorter latency)
					and UX improvements over the existing official solution.
				</li>
				<li>
					ONNX was used to perform vector-based search of courses with a pre-trained sentence
					transformer model. This approach yielded more robust and relevant search results compared
					to the existing solution.
				</li>
			</ul>
		</Entry>
	</Entry>

	<Entry>
		{#snippet title()}
			<h2 class="text-xl">Education</h2>
		{/snippet}
		<Entry date={['08/2022', '06/2025']}>
			{#snippet title()}
				<h3>BSc in Machine Learning and Data Science</h3>
			{/snippet}
			Copenhagen University (DIKU)
			<ul class="list-square list-inside">
				<li>7-point scale average of 11.0 / 12.0.</li>
				<li>
					Wrote my bachelor thesis on topological deep learning and graph representation learning,
					which then evolved into a reproducibility study of state of the art graph machine learning
					models. It can be found on GitHub, <a
						href="https://github.com/joshniemela/BottlenecksWithinGNN"
						class="text-purple-900 hover:text-purple-400">BottlenecksWithinGNNs</a
					>.
				</li>
			</ul>
		</Entry>
	</Entry>

	<Entry>
		{#snippet title()}
			<h2 class="text-xl">Skills</h2>
		{/snippet}
		<ul class="list-square list-inside">
			<li>C#/.NET, TypeScript/Svelte, Python, Rust, Julia, Clojure</li>
			<li>SDLC, AGILE, project management, software architecture, risk analysis</li>
			<li>GitHub Actions, Docker Compose, VPS and cloud hosting</li>
			<li>Machine learning, computer vision, deep learning, image processing, NLP, data science</li>
		</ul>
	</Entry>
</main>
