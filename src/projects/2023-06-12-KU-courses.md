---
author: "Joshua Niemelä"
desc: "My personal website for my projects and information about me."
lang: "en"
title: "KU courses"
github: "https://github.com/joshniemela/jniemela.dk"
languages: "Clojure, Svelte/TS, Python"
image: "images/ku-courses.png"
---

[See the website here](https://disku.jniemela.dk)

This is one of the larger projects that I have worked on. It is a website that serves you the courses on the faculty of science at the University of Copenhagen with significantly faster load times than the official website and with better search functionality. There are three components to the project:  
- A web scraper that scrapes the official website for courses and stores them in a database, written in Python, I wrote a large chunk of this, with Jákup Lützen doing the rest.
- A backend that serves the courses to the frontend, written in Clojure, this part was entirely written by me. It is a REST API that serves the courses in JSON format. It has full-text search functionality and a fully-fledged DSL for filtering the courses which is used by the frontend with arbitrarily complex queries. The server is written using [Reitit](https://github.com/metosin/reitit) and [next.jdbc](https://github.com/seancorfield/next-jdbc).  

- A frontend that displays the courses, written in [Svelte](https://github.com/sveltejs/svelte) and [TypeScript](https://github.com/microsoft/TypeScript), this part was mostly written by Kristian Pedersen (I designed a lot of the logic and helped with polishing the UI).

The project was then finally deployed to my personal server using Docker. The project is open source and can be found [here](https://github.com/joshniemela/KU-courses).
