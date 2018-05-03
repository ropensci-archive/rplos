# tests for plosword fxn in rplos
context("plosword")

test_that("plosword returns the correct value", {
	vcr::use_cassette("plosword1", {
    expect_that(names(plosword('Helianthus')), equals("Number of articles with search term"))
  })
})

test_that("plosword returns the correct class", {
  vcr::use_cassette("plosword2", {
  	expect_that(plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')[[2]],
  							is_a("ggplot"))
  })
})
