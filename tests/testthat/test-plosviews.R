# tests for plosviews fxn in rplos
context("plosviews")

test_that("plosviews returns the correct value", {
	expect_that(as.character(plosviews('10.1371/journal.pone.0002154', 'id', 'alltime', key = "hello")[,1]), prints_text("10.1371/journal.pone.0002154"))
	expect_that(nrow(plosviews('bird', views = 'alltime', limit = 18, key = "hello")), equals(18))
})

test_that("plosviews returns the correct class", {
	expect_that(plosviews('bird', views = 'alltime', limit = 18, key = "hello"), is_a("data.frame"))
	expect_that(plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30', key = "hello"), is_a("data.frame"))
})