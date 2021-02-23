context("plosfields")

skip_on_cran()
skip_if_offline()

test_that("plosfields returns the correct class", {
	data(plosfields, package="rplos")

	expect_that(class(plosfields), equals("data.frame"))
})

test_that("plosfields returns the correct dimensions of data.frame", {
	data(plosfields, package="rplos")

	expect_that(nrow(plosfields), equals(72))
	expect_that(length(names(plosfields)), equals(3))
})

test_that("plosfields returns the correct column names", {
	data(plosfields, package="rplos")

	expect_that(names(plosfields), equals(c("field","description","note")))
})
