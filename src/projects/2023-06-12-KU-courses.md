---
author: "Joshua Niemelä"
desc: "My personal website for my projects and information about me."
lang: "en"
title: "KU courses"
github: "https://github.com/joshniemela/jniemela.dk"
languages: "Clojure, Svelte/TS, Python"
image: "images/ku-courses.png"
last-modified: "2023-07-15"
---

[See the website here](https://disku.jniemela.dk)

This is one of the larger projects that I have worked on. It is a website that serves you the courses on the faculty of science at the University of Copenhagen with significantly faster load times than the official website and with better search functionality. There are three components to the project:  
- A web scraper that scrapes the official website for courses and stores them in a database, written in Python, I wrote a large chunk of this, with [Jákup Lützen](https://github.com/BinFlush) doing the rest.
- A backend that serves the courses to the frontend, written in Clojure, this part was entirely written by me. It is a REST API that serves the courses in JSON. It has full-text search functionality and a more precise fuzzy search compared to the original, with a speed-up of 5 to 400x depending on the query. In contrast to the original, this also doesn't include duplicates of the old courses and it is possible to search by coordinator name and exam type. The server is written using [Reitit](https://github.com/metosin/reitit) and [next.jdbc](https://github.com/seancorfield/next-jdbc).

- A frontend that displays the courses, written in [Svelte](https://github.com/sveltejs/svelte) and [TypeScript](https://github.com/microsoft/TypeScript), the initial draft and design was written by [Kristian Dam Pedersen](https://github.com/KristianDamPedersen), and I have since then rebuilt the entire frontend to its current more minimalistic and blocky design.


The project was then finally deployed to my personal server using Docker. The project is open source and can be found [here](https://github.com/joshniemela/KU-courses).
