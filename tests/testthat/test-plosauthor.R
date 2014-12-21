# tests for plosauthor fxn in rplos
context("plosauthor")

test_that("plosauthor returns the correct dimensions in the data.frame", {
	expect_equal(NROW(plosauthor(q = 'johnson', fl = 'title,author', limit = 100, key = "hello")$data), 100)
	expect_equal(length(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100, key = "hello")$data)), 2)
})

test_that("plosauthor returns the correct column names", {
	expect_equal(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100, key = "hello")$data), 
               c("author","title"))
})
