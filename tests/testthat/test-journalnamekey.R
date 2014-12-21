# tests for journalnamekey fxn in rplos
context("journalnamekey")

test_that("journalnamekey returns the correct value", {
	expect_output(paste0(journalnamekey(), collapse = " "), "PLoSONE")
})

test_that("journalnamekey returns the correct class", {
	expect_that(journalnamekey(), is_a("character"))
})

test_that("journalnamekey returns the correct length vector", {
	expect_that(length(journalnamekey()), equals(9))
})
