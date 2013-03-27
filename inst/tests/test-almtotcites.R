# tests for almtotcites fxn in rplos
context("almtotcites")

test_that("almtotcites returns the correct class", {
	expect_that(almtotcites('10.1371/journal.pbio.0000012'), is_a("numeric"))
	expect_that(almtotcites('10.1371/journal.pbio.1001357'), is_a("numeric"))
})