# tests for crossref_r and crosref fxn in rplos
context("crossref")

test_that("crossref returns the correct value", {
	expect_that(nchar(crossref("10.3998/3336451.0009.101")), equals(261))
})

test_that("crossref returns the correct class of bibentry", {
	expect_that(crossref("10.3998/3336451.0009.101"), is_a("bibentry"))
})