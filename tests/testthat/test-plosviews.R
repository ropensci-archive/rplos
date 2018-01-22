# tests for plosviews fxn in rplos
context("plosviews")

test_that("plosviews returns the correct value", {
	skip_on_cran()

	Sys.sleep(6)
	expect_equal(plosviews('10.1371/journal.pone.0002154', 'id', 'alltime')$id,
	            "10.1371/journal.pone.0002154")
	Sys.sleep(6)
	expect_equal(NROW(plosviews('bird', views = 'alltime', limit = 18)), 18)
})

test_that("plosviews returns the correct class", {
	skip_on_cran()

	expect_is(plosviews('bird', views = 'alltime', limit = 18), "data.frame")
	Sys.sleep(6)
	expect_is(plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30'),
	          "data.frame")
})
