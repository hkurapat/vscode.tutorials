# CLAUDE.md — vscode.tutorials

This is an R package (`vscode.tutorials`) containing **learnr** tutorials for learning VS Code in GitHub Codespaces. Tutorials live in `inst/tutorials/` as `tutorial.Rmd` files.

## Project layout

```
inst/tutorials/<name>/
  tutorial.Rmd       # main tutorial file
  data/              # RDS files and other data (available at run time)
  images/            # images included via include_graphics()
```

Current tutorials: `01-code` through `09-infrastructure`, `r4ds-1` through `r4ds-5`, `tidycensus-1`.

## Philosophy (AI era)

The goal is not to teach coding — it is to teach students how to **use AI to create**. Students should almost never see R code directly. Instead:

- Show students **results** (plots, printed tibbles, summary statistics), not the code that produced them.
- Questions ask students to prompt AI for code, run it, and compare their output to ours.
- `echo = FALSE` is the default everywhere. Only reveal code when there is a strong pedagogical reason.
- Test chunks (`exercise-N-test`) produce visible output after students click Continue — this is how we give them something concrete to check against.

## Student workflow

Students view all QMD output via **render + Live Server**, not by running code in the R Terminal:

- After editing `analysis.qmd`, students run `quarto render analysis.qmd` in a bash terminal.
- They open `analysis.html` with Live Server once at the start (right-click in File Explorer → "Open with Live Server"); it auto-refreshes on every subsequent render.
- **Never** instruct students to use `Cmd/Ctrl + Enter` to run QMD code or `Cmd/Ctrl + Shift + K` to render.
- `#| cache: true` is a **render-time** feature — the cache is created during `quarto render`, not by running code interactively. The first render with caching takes noticeably longer; subsequent renders load from disk.
- Add `analysis_cache` to `.gitignore`; cache files do not belong on GitHub.

## Tutorial structure

Every tutorial follows this order:

1. **Introduction** — overview of packages/functions covered; exercises to set up the repo, QMD, and libraries.
2. **1–2 Topics** — the substantive content; ends with a plotting sequence.
3. **Summary** — mirrors the Introduction in past tense; finishes with `quarto publish gh-pages` and a GitHub URL.

### Introduction exercises (standard sequence)

1. Create repo from `codespace-starter` template, open Codespace, create `analysis.qmd`, render, open `analysis.html` with Live Server, set up `.gitignore`, CP/CR.
2. Add `library(tidyverse)` to QMD with `#| message: false` and `execute: echo: false` in YAML, render, check Live Server tab, CP/CR.
3. In a bash terminal, run `quarto render analysis.qmd`; confirm the Live Server tab auto-refreshes. CP/CR.
4. (Optional) Create `data/` directory via `dir.create("data")`, CP/CR.

Replace `XX` placeholders with actual repo names, titles, and knowledge drops.

### Topic exercises

- Begin by downloading or loading data.
- Give students **one well-crafted AI prompt** to build the complete pipe in a single exercise — do not walk through it step-by-step across multiple exercises.
- End every topic with the **3-question plotting sequence** (see below).

### Plotting sequence (3 questions)

1. Verify the student's tibble matches yours — show our printed tibble in the test chunk, ask student to `show_file("analysis.qmd", chunk = "Last")` and CP/CR. Also display the correct pipe code verbatim in the exercise prose using `<pre><code>` (not an executable chunk) so students can copy-paste it if their result differs. Getting students onto the same pipe before plotting is a key crossroads — they must have the right data to proceed.
2. Assign the pipe result to `x` with `#| cache: true`. In a bash terminal, run `quarto render analysis.qmd`. Note that this first render takes time — Quarto runs the code and writes the cache to disk; subsequent renders skip that code and load from cache instead. CP/CR.
3. Ask AI to plot `x`. Student adds code to new chunk, runs `quarto render analysis.qmd`, checks Live Server tab, runs `show_file()`, CP/CR. Show our plot in the test chunk (no code visible).

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

- One or two sentences max — students will not read more.
- Place at the **end** of each exercise (after `###`), or at the **start** before the question when the context helps students answer.
- Focus on packages and functions students should know to mention to AI.
- No road signs ("In the next section..."). Teach something real.
- No rhetorical questions.

## Code chunk conventions

- Label format: `section-name-N` and `section-name-N-test` (e.g., `billboard-3`, `billboard-3-test`).
- Run `tutorial.helpers::check_current_tutorial()` after adding/deleting exercises to renumber everything.
- Use `tutorial.helpers::make_exercise()` to add new exercises with correct numbering.
- `echo = FALSE` everywhere (set globally in setup chunk via `knitr::opts_chunk$set(echo = FALSE)`).
- Set `knitr::opts_chunk$set(out.width = '90%')` in setup for consistent image sizing.

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

Pre-compute any objects needed in exercise chunks here. Load from RDS rather than downloading from the web (saves the RDS to `data/`, loads it unconditionally).

## Data handling

- Never download from the web at compile/run time — save to `data/` as RDS and `read_rds()` in setup.
- The first two lines (download + write_rds) get commented out after initial creation; the `read_rds()` line stays.
- For large data: switch to written exercises with CP/CR; create small versions of the data in setup for test chunks.

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
