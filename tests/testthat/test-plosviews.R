# tests for plosviews fxn in rplos
context("plosviews")

test_that("plosviews returns the correct value", {
	vcr::use_cassette("plosviews_values", {
		expect_equal(plosviews('10.1371/journal.pone.0002154', 'id', 'alltime')$id,
		            "10.1371/journal.pone.0002154")
		expect_equal(NROW(plosviews('bird', views = 'alltime', limit = 18)), 18)
	})
})

test_that("plosviews returns the correct class", {
	vcr::use_cassette("plosviews_class", {
		expect_is(plosviews('bird', views = 'alltime', limit = 18), "data.frame")
		expect_is(plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30'),
		          "data.frame")
	})
})
