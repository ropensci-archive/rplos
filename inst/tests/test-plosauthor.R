# tests for plosauthor fxn in rplos
context("plosauthor")

test_that("plosauthor returns the correct dimensions in the data.frame", {
	expect_that(nrow(plosauthor(terms = 'johnson', fields = 'title,author', limit = 100)), 
							equals(100))
	expect_that(nrow(plosauthor(terms = 'johnson', limit = 5)), 
							equals(5))
	expect_that(length(names(plosauthor(terms = 'johnson', fields = 'title,author', limit = 100))), 
							equals(2))
})

test_that("plosauthor returns the correct column names", {
	expect_that(names(plosauthor(terms = 'johnson', fields = 'title,author', limit = 100)), 
							equals(c("title","author")))
})

test_that("plosauthor returns the correct class", {
	expect_that(plosauthor(terms = 'johnson', limit = 5), is_a("data.frame"))
})