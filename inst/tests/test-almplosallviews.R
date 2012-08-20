# tests for almplosallviews fxn in rplos
context("almplosallviews")

test_that("almplosallviews returns the correct class", {
	expect_that(almplosallviews('10.1371/journal.pone.0002554', 'mendeley', 0, 1, 'json'), is_a("list"))
	expect_that(almplosallviews('10.1371/journal.pbio.0000012', 'counter', 1, 1, 'xml'), is_a("XMLDocument"))
	
})

test_that("almplosallviews returns the correct value", {
	expect_that(length(almplosallviews('10.1371/journal.pbio.0000012', 'citeulike', 0, 0, 'json')$article), 
							equals(7))
})