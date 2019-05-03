# set up vcr
library("vcr")
invisible(vcr::vcr_configure(dir = "../fixtures/vcr_cassettes"))

only_ascii <- function(path) {
  path <- file.path("../fixtures/vcr_cassettes", paste0(path, ".yml"))
  z <- tryCatch(
    suppressWarnings(suppressMessages(tools::showNonASCIIfile(path))),
    error = function(e) e, warning = function(w) w)
  if (inherits(z, c("error", "warning"))) {
    testthat::skip("fixture file not found")
  }
  length(z) == 0
}

# skips if non-ascii characters found in fixture - which could 
# cause errors reading the yaml fixture
skip_if_non_ascii <- function(path) {
  if (only_ascii(path)) return()
  testthat::skip("non ascii text in test fixture, skipping")
}
