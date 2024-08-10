<script lang="ts">
	import Project from '../../../components/Project.svelte';
</script>

<Project
	title="KU Courses"
	description="A more performant and user-friendly version of the KU course catalog"
	languagesUsed="Rust, Svelte, Clojure"
	github="https://github.com/joshniemela/KU-courses"
	lastUpdated="09-08-2024"
>
	<a href="https://disku.jniemela.dk"> Link to the website here </a>

	<div class="wrapper">
		<iframe src="https://disku.jniemela.dk" title="KU Courses" class="frame"></iframe>
	</div>
	<p>
		This is one of the larger projects that I have worked on. It is a website that serves you the
		courses on the faculty of science at the University of Copenhagen with significantly faster load
		times than the official website and with better search functionality. It also automatically
		collects and displays other peices of information a student might desire such as statistics,
		these typically require you to go looking through an entirely separate website by KU. There are
		several components to this project:
	</p>
	<ul>
		<li>
			A web scraper that scrapes the official website for courses and stores them in a PostgreSQL
			database.
		</li>
		<li>
			A parser that parses the scraped courses and stores them in a more structured format in the
			database, this part was written in Rust and is able to parse the courses significantly faster
			than the original parser in Python, taking about 120ms of single-threaded time to parse all
			courses, compared to the original which took about 90 seconds on 8 threads. This original
			parser was built by <a href="https://github.com/BinFlush"> Jákup Lützen </a> and it played an integral
			part in the development of the project.
		</li>
		<li>
			A backend that serves the courses to the frontend and glues the other services together,
			written in Clojure, this part was entirely written by me. It is a REST API that serves the
			courses in JSON. It is able to filter and query the courses significantly faster the original,
			with a speed-up of 2-20x depending on the query. In contrast to the original, this also
			doesn't include duplicates of the old courses and it is possible to search by coordinator name
			and exam type. Combined with the vector search module (see below), it is also possible to
			perform semantic searches on the contents and concepts of courses instead of verbatim
			full-text matching. The server is written using [Reitit](https://github.com/metosin/reitit)
			and [next.jdbc](https://github.com/seancorfield/next-jdbc).
		</li>
		<li>
			A frontend that displays the courses, written in <a href="https://github.com/sveltejs/svelte"
				>Svelte</a
			>
			and <a href="https://github.com/microsoft/TypeScript">Typescript</a>, the initial draft and
			design was written by
			<a href="https://github.com/KristianDamPedersen">Kristian Dam Pedersen</a>, and I have since
			then rebuilt the entire frontend to its current more minimalistic and blocky design.
		</li>
	</ul>

	<h1>/projects/KU Courses/history</h1>
	<p>
		The project has gone through several rewrites and refactors, the first one going from a quickly
		written botched website for an exam project to a more polished version. The successive updates
		were done to make it easier to maintain and to make it more performant and to remove a lot of
		dependencies as well as adding new features.
	</p>
	<h2>First update - Reskin</h2>
	The entire project's frontend was rewritten in Typescript and using TailwindCSS and the frontend was
	resigned to be more minimalistic and is still the current design being used. It was also made responsive
	so it would work on mobile devices and other small screens.

	<h2>Second update - API improvements</h2>
	The API was redone to have an overview and a detailed route to decrease the massive amounts of overfetching
	that was done, which lowered the fetching of all courses from 300ms to 50ms. Furthermore the PostgreSQL
	DB had GIN indices added to the text fields, this resulted in a 5x speed-up on text search. Since a
	lot of the searches tend to be duplicates (get all courses, find all in block 2... etc.), I decided
	to add a small wrapper to the course route to cache all queries, this gave a further speed-up of 5x
	on all queries encountered once before.
	<h2>Third update - In-memory database and vector search</h2>
	The backend was made to fetch courses and store them in an in-memory database, this was done to decrease
	the load on the filesystem and to increase the speed of the API. This resulted in a speedup of about
	40ms on all queries. The dependency on PostgesSQL was also removed at this point. With the removal
	of the PostgreSQL dependency, full-text search was no longer possible, this was replaced with a vector
	search service in Python that was able to search for courses semantically using a pre-trained sentence-transformers
	model.
	<h2>Fourth update - Statistics</h2>
	The official catalogue doesn't display statistics, this update was therefore made to automatically
	collect and display statistics on the courses, this was done by scraping the statistics from STADS
	and storing them as JSON. This was done to make it easier for students to find the statistics and to
	make it easier to compare courses. This was built as a separate module on the Clojure backend but is
	technically its own service, piggybacking on the JVM used by the backend.
	<h2>Fifth update - Bye bye Python</h2>
	The parser was outrageously slow, overengineered and was prone to unexpected errors, this was replaced
	with a Rust parser that was able to parse the courses significantly faster and without unhandled errors.
	The parser was to be very generic since it was originally built alongside the frontend before the specific
	requirements of the frontend were known, this was replaced with the more specific parser in Rust. This
	parser was about 6000x faster than the original. The vector search module was also rewritten to decrease
	the size of the service since it took up almost 3GB of disk space. The new service was about 20% faster
	and took up less than 1/50th of the space.
	<h2>Sixth update - The return of PostgreSQL</h2>
	The project at this point has HTML pages, parsed pages in JSON, statistics in JSON and vector embeddings
	all stored in random folders all throughout the project. This was a mess and was hard to maintain,
	so I decided to add a PostgreSQL database to centralise all data and have a single source of truth.
	The in-memory database is still being used for its faster queries on courses.
	<h2>Seventh update - Sort away the dreaded ITX exam</h2>
	Copenhagen University has an written exam type, called "ITX". This is an exam type that is done on
	a lobotomised windows computer with no shortcuts or software installed. It might work for the students
	studying humanities, but for STEM, writing proofs or code on Microsoft Word is a nightmare. This update
	incorporates a document found at KU lists what courses are ITX and not so it is now possible to differentiate
	between ITX and written exams.
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
		margin-top: 2em;
		margin-bottom: 1em;
		border: 2px solid var(--colour-orange);
	}
</style>
