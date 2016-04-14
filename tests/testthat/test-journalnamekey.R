# tests for journalnamekey fxn in rplos
context("journalnamekey")

test_that("journalnamekey returns the correct value", {
	skip_on_cran()

	expect_true(grepl("PLoSONE", paste0(journalnamekey(), collapse = " ")))
})

test_that("journalnamekey returns the correct class", {
	skip_on_cran()

	expect_that(journalnamekey(), is_a("character"))
})

test_that("journalnamekey returns the correct length vector", {
	skip_on_cran()

	expect_gt(length(journalnamekey()), 0)
})
