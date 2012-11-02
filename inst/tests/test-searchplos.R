# tests for searchplos fxn in rplos
context("searchplos")

test_that("searchplos returns the correct dimensions on the data.frame", {
	expect_that(nrow(searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)), equals(250))
})

test_that("searchplos returns the correct class", {
	expect_that(searchplos('ecology', 'id,publication_date', limit = 2), is_a("data.frame"))
	expect_that(searchplos('ecology', 'id,title', limit = 2), is_a("data.frame"))
})