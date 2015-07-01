# tests for check_response fxn in rplos
context("check_response")

library("httr")

sortspec <- 'http://api.plos.org/search?q=*:*&sort=counter_total_all%20desasdfc&wt=json'
datanotfound <- 'http://api.plos.org/search?qasdf=things&wt=json'
undef <- 'http://api.plos.org/search?q=*:*&facet.range=counter_total_all,alm_twitterCount&wt=json&fl=DOES_NOT_EXIST&facet=true'

test_that("check_response catches wrong sort specification correctly", {
	skip_on_cran()

  expect_error(check_response(httr::GET(sortspec)), "Can't determine a Sort Order")
  expect_error(searchplos(q="*:*", sort="counter_total_all desadfc"), "Can't determine a Sort Order")
})

test_that("check_response catches no data found correctly", {
	skip_on_cran()

  expect_message(check_response(httr::GET(datanotfound)), "no data found")
  expect_message(searchplos(q="monkey pies and cheese cows horses"), "no data found")
})

test_that("check_response catches undefined fields correctly", {
	skip_on_cran()

  expect_error(check_response(httr::GET(undef)), "undefined field")
})

test_that("check_response catches incorrect value to start", {
	skip_on_cran()

  expect_error(searchplos(q="*:*", start = "a"), "For input string")
})
