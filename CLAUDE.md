# CLAUDE.md — vscode.tutorials

This is an R package (`vscode.tutorials`) containing **learnr** tutorials for learning VS Code in GitHub Codespaces. Tutorials live in `inst/tutorials/` as `tutorial.Rmd` files.

## Project layout

```
inst/tutorials/<name>/
  tutorial.Rmd       # main tutorial file
  images/            # images included via include_graphics()

inst/extdata/<name>/ # stable source copies of data students may download
```

Current tutorials: `01-code` through `09-infrastructure`, `r4ds-1` through `r4ds-5`, `census`.

## Philosophy (AI era)

The goal is not to teach coding — it is to teach students how to **use AI to create data science artifacts**. After the initial VS Code and infrastructure tutorials, students should mostly interact with an AI agent that edits their files, renders their Quarto document, and helps them debug. They should learn to steer analysis, inspect output, notice problems, and ask for refinements.

- Show students **results** (plots, printed tibbles, summary statistics, rendered pages), not just the code that produced them.
- Questions ask students to prompt AI for file edits, render, inspect output, and compare their output to ours.
- Prefer many small exercises that form a data analysis path over one large prompt that solves the whole section.
- Students should not type R into learnr exercise chunks in post-infrastructure tutorials. Their work happens in `analysis.qmd` and supporting files.
- `echo = FALSE` is the default everywhere. Only reveal code when there is a strong pedagogical reason.
- Test chunks (`exercise-N-test`) may produce visible output after students click Continue — this is how we give them something concrete to check against, such as our example plot or tibble.

## Student workflow

Students view all QMD output via **render + Live Server**, not by running code in the R Terminal:

- After editing `analysis.qmd`, students run `quarto render analysis.qmd` in a bash terminal.
- They open `analysis.html` with Live Server once at the start (right-click in File Explorer → "Open with Live Server"); it auto-refreshes on every subsequent render.
- **Never** instruct students to use `Cmd/Ctrl + Enter` to run QMD code or `Cmd/Ctrl + Shift + K` to render.
- `#| cache: true` is a **render-time** feature — the cache is created during `quarto render`, not by running code interactively. The first render with caching takes noticeably longer; subsequent renders load from disk.
- Add `analysis_cache` to `.gitignore`; cache files do not belong on GitHub.

## Subject-area tutorials

Tutorials after `09-infrastructure` should be organized around prominent data sources and real data science domains, not around book chapters. Examples: US Census data, baseball data, stock data, Bitcoin, and other subject areas where students can learn what analysts actually use.

Each subject-area tutorial should teach:

- The gold-standard data sources for that area.
- The main R packages, APIs, file formats, and vocabulary students should mention to AI.
- Common data patterns, data quality issues, and standard analytical questions in that domain.
- A reproducible workflow that ends with a small published Quarto artifact.

## Tutorial structure

Every tutorial follows this order:

1. **Introduction** — overview of packages/functions covered; exercises to set up the repo, QMD, and libraries.
2. **Topic sections** — each section starts from data, follows an exploratory path, and usually ends with a useful plot or table plus a short interpretation.
3. **Summary** — mirrors the Introduction in past tense; finishes with `quarto publish gh-pages` and a GitHub URL.

### Introduction exercises (standard sequence)

1. Create repo from `codespace-starter` template, open Codespace, create `analysis.qmd`, render, open `analysis.html` with Live Server, set up `.gitignore`, CP/CR.
2. Add `library(tidyverse)` to QMD with `#| message: false` and `execute: echo: false` in YAML, render, check Live Server tab, CP/CR.
3. In a bash terminal, run `quarto render analysis.qmd`; confirm the Live Server tab auto-refreshes. CP/CR.
4. (Optional) Create `data/` directory via `dir.create("data")`, CP/CR.

Replace `XX` placeholders with actual repo names, titles, and knowledge drops.

### Topic exercises

- Begin by getting data into the student's project. Often this means asking AI to create `data/`, download a file from a stable URL, and record where it came from.
- Ask for one concrete edit per exercise. Do not micromanage individual R function arguments unless the detail is pedagogically important.
- Render after every meaningful edit. The Live Server tab is the student's feedback loop.
- Use several linked exercises to build an analysis path: inspect the data, notice a pattern or problem, refine the data, make a rough plot, improve the plot, add interpretation.
- The final section should make the rendered page look good enough to publish.

### Exercise rhythm

Most exercises should follow this rhythm:

1. **Prompt AI / edit `analysis.qmd`** — students ask their AI agent to add or change something concrete.
2. **Render** — students run `quarto render analysis.qmd` in a bash terminal and inspect the Live Server tab.
3. **Verify** — students CP/CR evidence that they completed the exercise. This might be output from the rendered HTML, a printed tibble, a plot description, a file listing, a URL, or `show_file("analysis.qmd", chunk = "Last")`.
4. **Show our example when useful** — the test chunk may display our plot, tibble, summary, or other expected output after submission.
5. **Knowledge drop** — after submission, provide a short paragraph that tells students what to notice, teaches domain knowledge, or foreshadows the next exercise.

The canonical loop is:

`prompt AI/edit analysis.qmd -> render -> inspect Live Server -> CP/CR evidence -> optional example output -> knowledge drop -> next exercise`

### Analysis path

Build topic sections from linked exercise units. A typical path:

1. Download or load data and document the source.
2. Inspect with `glimpse()`, `summary()`, `count()`, or a simple printed table.
3. Notice a problem or opportunity: too many categories, missing values, outliers, awkward variable names, an important subgroup, or an unclear plot.
4. Ask AI to refine the analysis.
5. Make a rough plot or table.
6. Improve labels, grouping, ordering, scale, caption, and visual polish.
7. Add a short interpretation paragraph about what the plot or table shows.

The final artifact should be a published page with a meaningful result about the world, not just a completed worksheet.

### Summary exercises (standard sequence)

1. Final `quarto render`, `show_file("analysis.qmd")`, CP/CR.
2. `quarto publish gh-pages analysis.qmd` in bash Terminal; paste resulting URL.
3. Commit and push; paste GitHub repo URL.

## Question types

### No-answer questions (default)

```r
question_text(NULL,
  answer(NULL, correct = TRUE),
  allow_retry = TRUE,
  try_again_button = "Edit Answer",
  incorrect = NULL,
  rows = 5)
```

Use for CP/CR questions. Set `rows` to match expected output length.

### Yes-answer questions

```r
question_text(NULL,
  message = "Correct answer text here.",
  answer(NULL, correct = TRUE),
  allow_retry = FALSE,
  incorrect = NULL,
  rows = 6)
```

Use when providing the correct answer. Set `allow_retry = FALSE`.

## Knowledge drops

- Usually one short paragraph; one or two sentences is often enough.
- Place after students submit an exercise (after `###`). Place before the question only when context is needed to answer.
- Reference our example output when the test chunk displays a plot, tibble, or summary.
- Tell students what to notice in their rendered output, explain why it matters, or identify the next natural data-science move.
- Use knowledge drops to teach the data science ecosystem for the tutorial's area: gold-standard data sources, common measures, important packages, file formats, APIs, data-quality issues, and standard patterns analysts look for.
- Focus on packages and functions students should know to mention to AI.
- No road signs ("In the next section..."). Teach something real.
- No rhetorical questions.

## Code chunk conventions

- Label format: `section-name-N` and `section-name-N-test` (e.g., `billboard-3`, `billboard-3-test`).
- Run `tutorial.helpers::check_current_tutorial()` after adding/deleting exercises to renumber everything.
- Use `tutorial.helpers::make_exercise()` to add new exercises with correct numbering.
- `echo = FALSE` everywhere (set globally in setup chunk via `knitr::opts_chunk$set(echo = FALSE)`).
- Set `knitr::opts_chunk$set(out.width = '90%')` in setup for consistent image sizing.
- Avoid exercise code chunks in post-infrastructure tutorials. Use question chunks for CP/CR and test chunks for our example output.

## Setup chunk requirements

```r
library(learnr)
library(tutorial.helpers)
library(tidyverse)
# ...other libraries...

knitr::opts_chunk$set(echo = FALSE)
knitr::opts_chunk$set(out.width = '90%')
options(tutorial.exercise.timelimit = 60, tutorial.storage = "local")
```

Pre-compute only what the tutorial itself needs to show examples after submission. Do not load data merely to support student exercise code chunks in post-infrastructure tutorials.

## Data handling

- Never depend on a fragile third-party URL at tutorial run time.
- Keep stable source copies for student downloads under `inst/extdata/<tutorial>/` when practical, and document the original source.
- Students usually create their own `data/` directory inside their project and download or copy data there.
- Avoid `inst/tutorials/<name>/data/` for new post-infrastructure tutorials unless there is a specific learnr runtime reason.
- Do not download from the web during tutorial compile/run. If a test chunk needs data, load a small stable copy from the package.
- For large data, create smaller teaching files and use CP/CR verification rather than heavy test computations.

## Authoring with AI agents

When changing or creating subject-area tutorials, use Claude/Gemini iteratively:

- Ask the agent to inspect the existing tutorial and propose changes before editing.
- Correct the agent's plan when it misses project rules, especially the render + Live Server workflow, no post-infrastructure exercise code chunks, data handling, and knowledge drops.
- Make one section correct first. Render it, inspect the result, and revise before applying the same pattern elsewhere.
- Ask the agent what it will do in the next section before it edits.
- Keep expected output, prose, prompts, knowledge drops, and displayed example plots in sync when the data or analysis changes.

## Images

- Store in `images/` directory alongside `tutorial.Rmd`.
- Include with `knitr::include_graphics("images/example.png")` in an unnamed chunk.
- Requires `library(knitr)` in the setup chunk.

## Displaying code verbatim in tutorials

Use `<pre><code>` wrappers (not four backticks) to display R code chunks verbatim inside tutorial text:

```
<pre><code>```{r}
1 + 1
```</code></pre>
```

## Checking a tutorial

1. **Quick syntax check**: `rmarkdown::render("inst/tutorials/name/tutorial.Rmd")` — open resulting HTML in browser.
2. **Full check**: `devtools::check()` (`Cmd/Ctrl + Shift + E`) — must pass before any PR.
3. **Student perspective**: `devtools::install()` then `learnr::run_tutorial("tutorial_name", "vscode.tutorials")`.

`devtools::check()` validates that all tutorials include the default `copy-code-chunk` and `download-answers` chunks from the `tutorial_template`. Do not remove or alter these.

## Formatting conventions

- Keyboard input and inline code: `backticks`
- Package names: **bolded**
- Function names always include parentheses: `read_csv()`, not `read_csv`
- Section/topic titles: sentence case
- Abbreviation: CP/CR = Copy/Paste the Command/Response

## DESCRIPTION

Any library loaded in a tutorial must appear under `Imports` or `Suggests` in `DESCRIPTION`. `devtools::check()` on GitHub Actions will fail if a package is `library()`-ed but not listed.
