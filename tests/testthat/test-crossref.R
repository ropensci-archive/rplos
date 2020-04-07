# tests for crossref deprecated fxn in rplos
context("crossref")

test_that("crossref responds correctly", {
  skip_on_cran()
  
  mssg <- "Crossref functionality moved to package rcrossref"
  expect_error(crossref(), mssg, class="error")
  expect_error(crossref(a = 5), mssg, class="error")
})
