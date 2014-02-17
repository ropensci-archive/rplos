# tests for plossubject fxn in rplos
context("plossubject")

tt <- plossubject(q='marine ecology', fl = 'id,journal', fq='doc_type:full', limit = 9)

test_that("plossubject returns the correct class", {
	expect_that(tt, is_a("data.frame"))
	expect_that(dim(tt), equals(c(9,2)))
	expect_that(tt$journal, is_a("character"))
})