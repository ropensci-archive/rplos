# tests for searchplos fxn in rplos
context("searchplos")

test_that("searchplos returns the correct", {
  skip_on_cran()

  dat1 <- searchplos('ecology', 'id,publication_date', limit = 2)
  dat2 <- searchplos(q="*:*", fl='id', fq='cross_published_journal_key:PLoSONE', start=0, limit=15)

  # values
	expect_that(nrow(dat1$data), equals(2))
	expect_that(ncol(dat1$data), equals(2))
	expect_that(nrow(dat2$data), equals(15))
	expect_that(ncol(dat2$data), equals(1))

  # classes
  expect_that(dat1$data[1,1][[1]], is_a("character"))
  expect_that(dat2$data[1,1][[1]], is_a("character"))
	expect_that(dat1$data, is_a("data.frame"))
  expect_that(dat2$data, is_a("data.frame"))
  expect_is(dat2, "list")
  expect_is(dat2$meta, "data.frame")

  # searchplos returns the correct value
  skip_on_cran()

  expect_that(grepl('10.1371', dat2$data[1,1]), is_true())
})

test_that("searchplos catches bad limit param", {
  skip_on_cran()

  expect_error(searchplos(q="*:*", limit = "a"), "limit should be a numeric")
})
