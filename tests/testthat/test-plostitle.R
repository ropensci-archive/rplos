# tests for plostitle fxn in rplos
context("plostitle")

test_that("plostitle returns the correct dimensionsed data.frame", {
	skip_on_cran()

	Sys.sleep(5)
	expect_that(nrow(plostitle(q='drosophila', fl='title', limit=19)$data),
							equals(19))
	Sys.sleep(5)
	expect_that(length(names(plostitle(q='drosophila', fl='title', limit=19)$data)),
							equals(1))
	Sys.sleep(5)
	expect_that(names(plostitle(q='drosophila', fl='title,journal', limit = 5)$data),
							equals(c("journal","title")))
})

test_that("plostitle returns the correct class", {
	skip_on_cran()

	expect_is(plostitle(q='drosophila',  limit = 5)$data, "data.frame")
	Sys.sleep(5)
	expect_is(plostitle(q='drosophila', fl='title,journal', limit = 5)$data, "data.frame")
})
