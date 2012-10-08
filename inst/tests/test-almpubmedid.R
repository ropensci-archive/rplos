# tests for almpubmedid fxn in rplos
context("almpubmedid")

test_that("almpubmedid returns the correct value", {
	expect_that(almpubmedid('10.1371/journal.pbio.0000012'), equals("14551910"))
})

test_that("almpubmedid returns the correct class", {
	expect_that(almpubmedid('10.1371/journal.pbio.0000012'), is_a("character"))
})