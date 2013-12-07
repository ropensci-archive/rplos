# tests for plostitle fxn in rplos
context("plostitle")

test_that("plostitle returns the correct dimensionsed data.frame", {
	expect_that(nrow(plostitle(q='drosophila', fl='title', limit=19)$data), 
							equals(19))
	expect_that(length(names(plostitle(q='drosophila', fl='title', limit=19)$data)), 
							equals(1))
	expect_that(names(plostitle(q='drosophila', fl='title,journal', limit = 5)$data), 
							equals(c("journal","title")))
})

test_that("plostitle returns the correct class", {
	expect_that(plostitle(q='drosophila',  limit = 5)$data, is_a("data.frame"))
	expect_that(plostitle(q='drosophila', fl='title,journal', limit = 5)$data, is_a("data.frame"))
})