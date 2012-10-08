# tests for plosabstract fxn in rplos
context("plosabstract")

test_that("plosabstract returns the correct length list", {
	expect_that(length(plosabstract(terms = 'drosophila', fields='abstract', limit=10)), 
							equals(10))
	expect_that(length(plosabstract(terms = 'drosophila', fields='abstract', limit=5)), 
							equals(5))
})

test_that("plosabstract returns the correct class", {
	expect_that(plosabstract(terms = 'drosophila', fields='author', limit = 5), 
							is_a("list"))
	expect_that(plosabstract(terms = 'drosophila', fields='author', limit = 5)[[1]], 
							is_a("character"))
})