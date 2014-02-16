# tests for plosauthor fxn in rplos
context("plosauthor")

test_that("plosauthor returns the correct dimensions in the data.frame", {
	expect_that(nrow(plosauthor(q = 'johnson', fl = 'title,author', limit = 100)$data), 
							equals(100))
	expect_that(length(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100)$data)), 
							equals(2))
})

test_that("plosauthor returns the correct column names", {
	expect_that(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100)$data), 
							equals(c("title","author")))
})