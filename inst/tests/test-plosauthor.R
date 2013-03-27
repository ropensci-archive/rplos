# tests for plosauthor fxn in rplos
context("plosauthor")

test_that("plosauthor returns the correct dimensions in the data.frame", {
	expect_that(nrow(plosauthor(terms = 'johnson', fields = 'title,author', limit = 100)), 
							equals(100))
	expect_that(length(names(plosauthor(terms = 'johnson', fields = 'title,author', limit = 100))), 
							equals(2))
})

test_that("plosauthor returns the correct column names", {
	expect_that(names(plosauthor(terms = 'johnson', fields = 'title,author', limit = 100)), 
							equals(c("author","title")))
})