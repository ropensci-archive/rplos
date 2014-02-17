# tests for plostitle fxn in rplos
context("plostitle")

test_that("plostitle returns the correct dimensionsed data.frame", {
	expect_that(nrow(plostitle(q='drosophila', fl='title', limit=19)), 
							equals(19))
	expect_that(length(names(plostitle(q='drosophila', fl='title', limit=19))), 
							equals(1))
	expect_that(names(plostitle(q='drosophila', fl='title,journal', limit = 5)), 
							equals(c("journal","title")))
})

test_that("plostitle returns the correct class", {
	expect_that(plostitle(q='drosophila',  limit = 5), is_a("data.frame"))
	expect_that(plostitle(q='drosophila', fl='title,journal', limit = 5), is_a("data.frame"))
})