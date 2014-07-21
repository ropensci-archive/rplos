# tests for plosauthor fxn in rplos
context("plosauthor")

test_that("plosauthor returns the correct dimensions in the data.frame", {
	expect_equal(nrow(plosauthor(q = 'johnson', fl = 'title,author', limit = 100, key = "hello")), 100)
	expect_equal(length(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100, key = "hello"))), 2)
})

test_that("plosauthor returns the correct column names", {
	expect_that(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100, key = "hello")), 
							equals(c("author","title")))
})