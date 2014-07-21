# tests for plosabstract fxn in rplos
context("plosabstract")

test_that("plosabstract returns the correct dimensioned data.frame", {
	expect_equal(nrow(plosabstract(q = 'drosophila', fl='abstract', limit=10, key = "hello")), 10)
	expect_equal(nrow(plosabstract(q = 'drosophila', fl='abstract', limit=5, key = "hello")), 5)
})

test_that("plosabstract returns the correct class", {
	expect_is(plosabstract(q = 'drosophila', fl='author', limit = 5, key = "hello"), "data.frame")
	expect_is(plosabstract(q = 'Jones', fl='author', limit = 5, key = "hello")[1,1], "character")
})