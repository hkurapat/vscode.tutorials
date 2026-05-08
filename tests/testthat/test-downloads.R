# Tests that URLs students are instructed to download from in 03-terminal are
# still reachable. We check for text/plain content-type to catch cases where a
# URL silently redirects to an HTML error page instead of the raw file.
check_url_is_plain_text <- function(url) {
  resp <- httr2::request(url) |> httr2::req_perform()
  expect_equal(httr2::resp_status(resp), 200)
  expect_match(httr2::resp_content_type(resp), "text/plain")
}

# skip_on_cran(): CRAN check servers have no internet access.
# skip_if_offline(): avoid failures in local environments without internet.

test_that("03-terminal: AUTHORS file is downloadable", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  check_url_is_plain_text(
    "https://raw.githubusercontent.com/wch/r-source/trunk/doc/AUTHORS"
  )
})

test_that("03-terminal: TODO.txt is downloadable", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  check_url_is_plain_text(
    "https://raw.githubusercontent.com/PPBDS/vscode.tutorials/refs/heads/main/TODO.txt"
  )
})

test_that("03-terminal: grepping.txt is downloadable", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  check_url_is_plain_text(
    "https://raw.githubusercontent.com/PPBDS/vscode.tutorials/refs/heads/main/inst/tutorials/03-terminal/images/grepping.txt"
  )
})
