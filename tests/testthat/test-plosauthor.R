# tests for plosauthor fxn in rplos
context("plosauthor")

test_that("plosauthor returns the correct dimensions in the data.frame", {
	vcr::use_cassette("plosauthor_dims", {
  	expect_equal(NROW(plosauthor(q = 'johnson', fl = 'title,author', limit = 100)$data), 100)
  	expect_equal(length(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100)$data)), 2)
  })
})

test_that("plosauthor returns the correct column names", {
  vcr::use_cassette("plosauthor_cols", {
  	expect_equal(names(plosauthor(q = 'johnson', fl = 'title,author', limit = 100)$data),
               c("author","title"))
  })
})
