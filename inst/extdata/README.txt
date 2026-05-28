This directory holds stable source copies of data files used by tutorials. Each
tutorial has its own subdirectory (e.g. r4ds-1/). Tutorial exercises download
files from these paths via GitHub raw URLs; test chunks load them with
system.file("extdata/<tutorial>/file", package = "vscode.tutorials").

r4ds-1/music.csv
  10,000-song sample from the Million Song Dataset via CORGIS
  (https://corgis-edu.github.io/corgis/csv/music/). Contains audio features
  and metadata derived from the Echo Nest API: artist name, song title, tempo,
  duration, loudness, key, time signature, year, and "hotttnesss" scores.

Making babynames into a duckdb:

> usethis::use_directory("inst/extdata")
✔ Setting active project to
  "/Users/spgn/Desktop/vscode.tutorials".
> con <- DBI::dbConnect(
+   duckdb::duckdb(),
+   dbdir = "inst/extdata/babynames.duckdb"
+ )
> DBI::dbWriteTable(con, "babynames", babynames::babynames, overwrite = TRUE)
+ DBI::dbDisconnect(con, shutdown = TRUE)
                     
> list.files("inst/extdata")
[1] "babynames.duckdb" "README.txt"      


Making flights into a duckdb:

> usethis::use_directory("inst/extdata")
✔ Setting active project to
  "/Users/spgn/Desktop/vscode.tutorials".
 con <- DBI::dbConnect(
  duckdb::duckdb(),
  dbdir = "inst/extdata/flights.duckdb"
 )
> DBI::dbWriteTable(con, "flights", nycflights13::flights, overwrite = TRUE)
+ DBI::dbDisconnect(con, shutdown = TRUE)
                     
> list.files("inst/extdata")
[1] "babynames.duckdb" "flights.duckdb"   "README.txt"      
