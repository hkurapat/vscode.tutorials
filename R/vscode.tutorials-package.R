#' VS Code Tutorials
#'
#' A comprehensive collection of interactive tutorials covering VS Code and modern
#' development workflows. This package makes extensive use of the tools in the
#' tutorial.helpers package.
#'
#' @description
#' The vscode.tutorials package provides interactive tutorials focused on VS Code
#' and modern development tools, covering scripts, Quarto documents, the terminal,
#' Git, GitHub, and Quarto websites.
#'
#' @section VS Code and Development Tools Tutorials:
#' The package includes tutorials focused on VS Code and modern R development:
#' \itemize{
#'   \item \strong{VS Code and Scripts} (01-code): Introduction to VS Code and writing R code in simple scripts
#'   \item \strong{VS Code and Quarto} (02-quarto): Advanced R coding tricks in VS Code and Quarto document creation
#'   \item \strong{Terminal} (03-terminal): Command line fundamentals
#'   \item \strong{AI Introduction} (04-ai-1): Meeting the Gemini CLI agent and using it to create and render a Quarto analysis
#'   \item \strong{VS Code and GitHub Introduction} (05-github-1): Git and GitHub basics within VS Code
#'   \item \strong{VS Code and GitHub Advanced} (06-github-2): Advanced Git/GitHub workflows and GitHub Pages
#'   \item \strong{AI and Git} (07-ai-2): Using the Gemini CLI to run and explain a full Git workflow
#'   \item \strong{Quarto Websites Introduction} (08-websites-1): Basic website construction using Quarto projects
#'   \item \strong{Quarto Websites Advanced} (09-websites-2): Advanced Quarto websites with modular data analysis
#'   \item \strong{Infrastructure} (10-infrastructure): A tour of devcontainers and how they keep Codespaces consistent
#' }
#'
#' @section Running Tutorials:
#' To run a tutorial, use:
#' \code{learnr::run_tutorial(name = "short_tutorial_name", package = "vscode.tutorials")}
#'
#' Available tutorial names include: 01-code, 02-quarto, 03-terminal, 04-ai-1,
#' 05-github-1, 06-github-2, 07-ai-2, 08-websites-1, 09-websites-2, and
#' 10-infrastructure.
#'
#' @importFrom tutorial.helpers show_file
#' @importFrom usethis use_git_config
#'
#' @keywords internal
"_PACKAGE"
