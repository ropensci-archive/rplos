# tests for almdatepub fxn in rplos
context("almdatepub")

test_that("almdatepub returns the correct value", {
	expect_that(almdatepub('10.1371/journal.pone.0026871'), matches("2012-03-26"))
	expect_that(almdatepub('10.1371/journal.pone.0026871', 'year'), equals(2012))
	expect_that(almdatepub(doi="10.1371/journal.pone.002699", get='year'), equals(NA))
})

test_that("almdatepub returns the correct class", {
	expect_that(almdatepub('10.1371/journal.pone.0026871'), is_a("character"))
	expect_that(almdatepub('10.1371/journal.pone.0026871', 'year'), is_a("numeric"))
})
