# tests for searchplos fxn in rplos
context("searchplos")

test_that("searchplos returns the correct", {
  vcr::use_cassette("searchplos", {
    dat1 <- searchplos('ecology', 'id,publication_date', limit = 2)
    dat2 <- searchplos(q="*:*", fl='id', fq='journal_key:PLoSONE', start=0, limit=15)

    # values
  	expect_that(nrow(dat1$data), equals(2))
  	expect_that(ncol(dat1$data), equals(2))
  	expect_that(nrow(dat2$data), equals(15))
  	expect_that(ncol(dat2$data), equals(1))

    # classes
    expect_is(dat1$data[1,1][[1]], "character")
    expect_is(dat2$data[1,1][[1]], "character")
  	expect_is(dat1$data, "data.frame")
    expect_is(dat2$data, "data.frame")
    expect_is(dat2, "list")
    expect_is(dat2$meta, "data.frame")

    # searchplos returns the correct value
    expect_that(grepl('10.1371', dat2$data[1,1]), is_true())
  })
})

test_that("searchplos pagination handles large numbers correctly", {
  vcr::use_cassette("searchplos_large_numbers", {
    # without L
    dat2 <- searchplos(q="*:*", fl='id', start=1000000, limit=15)

    expect_is(dat2, "list")
    expect_equal(dat2$meta$start, 1000000)
    expect_equal(NROW(dat2$data), 15)

    # with L
    dat3 <- searchplos(q="*:*", fl='id', start=1000000L, limit=15)

    expect_is(dat3, "list")
    expect_equal(dat3$meta$start, 1000000)
    expect_equal(NROW(dat3$data), 15)
  })
})

test_that("searchplos catches bad limit param", {
  skip_on_cran()

  expect_error(searchplos(q="*:*", limit = "a"), "limit should be a numeric")
})
