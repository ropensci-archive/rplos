# tests for check_response fxn in rplos
context("check_response")

sortspec <- 'http://api.plos.org/search?q=*:*&sort=counter_total_all%20desasdfc&wt=json'
datanotfound <- 'http://api.plos.org/search?qasdf=things&wt=json'
undef <- 'http://api.plos.org/search?q=*:*&facet.range=counter_total_all,alm_twitterCount&wt=json&fl=DOES_NOT_EXIST&facet=true'

test_that("check_response catches wrong sort specification correctly", {
  expect_error(check_response(httr::GET(sortspec)), "Can't determine a Sort Order")
  expect_error(searchplos(q="*:*", sort="counter_total_all desadfc"), "Can't determine a Sort Order")
})

test_that("check_response catches no data found correctly", {
  expect_error(check_response(httr::GET(datanotfound)), "no data found")
  expect_error(searchplos(q="monkey pies and cheese cows horses"), "Can't determine a Sort Order")
})

test_that("check_response catches undefined fields correctly", {
  expect_error(check_response(httr::GET(undef)), "undefined field")
})

test_that("check_response catches incorrect value to start", {
  expect_error(searchplos(q="*:*", start = "a"), "undefined field")
})

test_that("check_response catches incorrect value to start", {
  expect_error(searchplos(), "undefined field")
})