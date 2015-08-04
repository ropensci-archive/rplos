# tests for crossref deprecated fxn in rplos
context("crossref")

test_that("crossref responds correctly", {
  skip_on_cran()
  
  mssg <- "Crossref functionality moved to package rcrossref"
  expect_error(crossref(), mssg)
  expect_error(crossref(a = 5), mssg)
})
