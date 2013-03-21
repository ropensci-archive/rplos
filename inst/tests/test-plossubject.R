# tests for plossubject fxn in rplos
context("plossubject")

test_that("plossubject returns the correct class", {
	expect_that(plossubject('ecology',  fields = 'abstract', limit = 20), 
							is_a("data.frame"))
	expect_that(plossubject('ecology',  limit = 5)[,"score"][[1]], 
							is_a("numeric"))
})