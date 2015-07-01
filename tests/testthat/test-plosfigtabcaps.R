# tests for plosfigtabcaps fxn in rplos
context("plosfigtabcaps")

test_that("plosfigtabcaps returns the correct dimenion result", {
	skip_on_cran()

	dat <- plosfigtabcaps(q='ecology', fl='figure_table_caption', limit=10)

	# correct values
	expect_that(NROW(dat$data), equals(10))
	expect_that(length(names(dat$data)), equals(1))
	expect_that(names(dat$data), equals("figure_table_caption"))
	expect_that(names(plosfigtabcaps(q='ecology', fl='id', limit=10)$data),
							equals("id"))

	# correct class
	expect_is(dat, "list")
	expect_is(dat$meta, "data.frame")
	expect_is(dat$data, "data.frame")
})
