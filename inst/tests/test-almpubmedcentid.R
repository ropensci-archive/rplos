# tests for almpubmedcentid fxn in rplos
context("almpubmedcentid")

test_that("almpubmedcentid returns the correct value", {
	expect_that(almpubmedcentid('10.1371/journal.pbio.0000012'), equals("212692"))
})

test_that("almpubmedcentid returns the correct class", {
	expect_that(almpubmedcentid('10.1371/journal.pbio.0000012'), is_a("character"))
})