# tests for plosabstract fxn in rplos
context("plosabstract")

test_that("plosabstract returns the correct dimensioned data.frame", {
	expect_that(nrow(plosabstract(q = 'drosophila', fl='abstract', limit=10, key = "hello")), 
							equals(10))
	expect_that(nrow(plosabstract(q = 'drosophila', fl='abstract', limit=5, key = "hello")), 
							equals(5))
})

test_that("plosabstract returns the correct class", {
	expect_that(plosabstract(q = 'drosophila', fl='author', limit = 5, key = "hello"), 
							is_a("data.frame"))
	expect_that(plosabstract(q = 'Jones', fl='author', limit = 5, key = "hello")[1,1], 
							is_a("character"))
})