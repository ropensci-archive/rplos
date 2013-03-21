# tests for plosfields fxn in rplos
context("plosfields")

data(plosfields)

test_that("plosfields returns the correct class", {
	expect_that(class(plosfields), equals("data.frame"))
})

test_that("plosfields returns the correct dimensions of data.frame", {
	expect_that(nrow(plosfields), equals(48))
	expect_that(length(names(plosfields)), equals(3))
})

test_that("plosfields returns the correct column names", {
	expect_that(names(plosfields), equals(c("field","description","note")))
})