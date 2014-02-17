# tests for plosabstract fxn in rplos
context("plosabstract")

test_that("plosabstract returns the correct dimensioned data.frame", {
	expect_that(nrow(plosabstract(q = 'drosophila', fl='abstract', limit=10)), 
							equals(10))
	expect_that(nrow(plosabstract(q = 'drosophila', fl='abstract', limit=5)), 
							equals(5))
})

test_that("plosabstract returns the correct class", {
	expect_that(plosabstract(q = 'drosophila', fl='author', limit = 5), 
							is_a("data.frame"))
	expect_that(plosabstract(q = 'Jones', fl='author', limit = 5)[1,1], 
							is_a("character"))
})