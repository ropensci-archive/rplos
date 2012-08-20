# tests for crossref_r and crosref fxn in rplos
context("crossref_r")

test_that("crossref_r returns a DOI", {
	expect_that(crossref_r()[[1]], matches("10\\..+"))
	expect_that(crossref_r()[[10]], matches("10\\..+"))
})

test_that("crossref_r returns 20 DOIs", {
	expect_that(length(crossref_r()), equals(20))
})