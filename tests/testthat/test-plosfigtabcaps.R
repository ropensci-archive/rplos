context("plosfigtabcaps")

skip_on_cran()
skip_if_offline()

test_that("plosfigtabcaps returns the correct dimenion result", {
	vcr::use_cassette("plosfigtabcaps", {
		dat <- plosfigtabcaps(q='ecology', fl='figure_table_caption', limit=10)
	}, preserve_exact_body_bytes = TRUE)

	# correct values
	expect_that(NROW(dat$data), equals(10))
	expect_that(length(names(dat$data)), equals(1))
	expect_that(names(dat$data), equals("figure_table_caption"))

	vcr::use_cassette("plosfigtabcaps_id", {
		expect_that(names(plosfigtabcaps(q='ecology', fl='id', limit=10)$data),
							equals("id"))
	})

	# correct class
	expect_is(dat, "list")
	expect_is(dat$meta, "data.frame")
	expect_is(dat$data, "data.frame")
})
