  # tests for almplosallviews fxn in rplos
context("almplosallviews")

dat <- almplosallviews(doi='10.1371/journal.pone.0039395', info='detail')

test_that("almplosallviews returns the correct class", {
	expect_that(dat, is_a("list"))
	
})