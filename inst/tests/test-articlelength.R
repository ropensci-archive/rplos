# tests for articlelength fxn in rplos
context("articlelength")

test_that("articlelength returns the correct length of text", {
	expect_that(articlelength("10.1371/journal.pone.0004045", "body"), equals(4365))
	expect_that(articlelength("10.1371/journal.pone.0004045", "title"), equals(9))
})

test_that("articlelength returns the correct class type", {
	expect_that(articlelength('10.1371/journal.pbio.0000012'), is_a("integer"))
})