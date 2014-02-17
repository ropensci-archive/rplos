# tests for searchplos fxn in rplos
context("searchplos")

dat1 <- searchplos('ecology', 'id,publication_date', limit = 2)
dat2 <- searchplos(q="*:*", fl='id', fq='cross_published_journal_key:PLoSONE', start=0, limit=15)

test_that("searchplos returns the correct dimensions", {
	expect_that(nrow(dat1), equals(2))
	expect_that(ncol(dat1), equals(2))
	expect_that(nrow(dat2), equals(15))
	expect_that(ncol(dat2), equals(1))
})

test_that("searchplos returns the correct class", {
  expect_that(dat1[1,1][[1]], is_a("character"))
  expect_that(dat2[1,1][[1]], is_a("character"))
	expect_that(dat1, is_a("data.frame"))
  expect_that(dat2, is_a("data.frame"))
})

test_that("searchplos returns the correct value", {
  expect_that(grepl('10.1371', dat2[1,1]), is_true())
})