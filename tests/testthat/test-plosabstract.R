# tests for plosabstract fxn in rplos
context("plosabstract")

test_that("plosabstract returns the correct dimensioned data.frame", {
	vcr::use_cassette("plosabstract", {
		expect_equal(
		  NCOL(plosabstract(q = 'drosophila', fl='abstract,id', limit=10)$data), 2)
		expect_equal(
		  NROW(plosabstract(q = 'drosophila', fl='abstract', limit=5)$data), 5)
	}, preserve_exact_body_bytes = TRUE)
})

test_that("plosabstract returns the correct class", {
	vcr::use_cassette("plosabstract_class", {
		expect_is(plosabstract(q = 'drosophila', fl='author', limit = 5)$data,
		          "data.frame")
		expect_is(plosabstract(q = 'Jones', fl='author', limit = 5)$data[1,1],
		          "tbl_df")
	}, preserve_exact_body_bytes = TRUE)
})
