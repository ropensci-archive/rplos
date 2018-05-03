# tests for journalnamekey fxn in rplos
context("journalnamekey")

test_that("journalnamekey returns the correct value", {
	vcr::use_cassette("journalnamekey1", {
  	expect_true(grepl("PLoSONE", paste0(journalnamekey(), collapse = " ")))
  })
})

test_that("journalnamekey returns the correct class", {
	vcr::use_cassette("journalnamekey2", {
  	expect_that(journalnamekey(), is_a("character"))
  })
})

test_that("journalnamekey returns the correct length vector", {
	vcr::use_cassette("journalnamekey3", {
  	expect_gt(length(journalnamekey()), 0)
  })
})
