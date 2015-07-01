# tests for plossubject fxn in rplos
context("plossubject")

test_that("plossubject returns the correct class", {
	skip_on_cran()

	tt <- plossubject(q='marine ecology', fl = 'id,journal', fq='doc_type:full', limit = 9)

	expect_that(tt$data, is_a("data.frame"))
	expect_that(dim(tt$data), equals(c(9,2)))
	expect_that(tt$data$journal, is_a("character"))
})
