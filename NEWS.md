# vscode.tutorials (development version)

* Split the AI tutorial into two and reordered the curriculum. `04-ai-1`
  (**AI Introduction**) now comes right after the terminal tutorial and
  introduces the Gemini CLI agent (create and render a Quarto analysis, no
  Git). `07-ai-2` (**AI and Git**) comes after the Git tutorials and uses
  Gemini to run and explain a full Git workflow. Full sequence is now
  `01-code`, `02-quarto`, `03-terminal`, `04-ai-1`, `05-github-1`,
  `06-github-2`, `07-ai-2`, `08-websites-1`, `09-websites-2`,
  `10-infrastructure`.

* The Git tutorials (`05-github-1`, `06-github-2`) now note that either AI
  approach --- a chat window with copy/paste, or the Gemini CLI agent --- is
  fine, since students have met the agent in `04-ai-1`.

* Reduced the advanced websites tutorial (`09-websites-2`) from three
  websites to two, folding the RDS/script workflow into Website 2.

* Refreshed the package-level documentation to list all ten tutorials.


# vscode.tutorials 0.0.2

* Renamed package from `positron.tutorials` to `vscode.tutorials`.

* Removed `renv` configuration.

# vscode.tutorials 0.0.1

* Initial release.
