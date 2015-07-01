# tests for plosword fxn in rplos
context("plosword")

test_that("plosword returns the correct value", {
	skip_on_cran()

	expect_that(names(plosword('Helianthus')), equals("Number of articles with search term"))
})

test_that("plosword returns the correct class", {
	skip_on_cran()

	expect_that(plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')[[2]],
							is_a("ggplot"))
})
