# tests for alm fxn in rplos
context("alm")

dat <- alm(doi='10.1371/journal.pone.0039395', info='detail')

test_that("alm returns the correct class", {
	expect_that(dat, is_a("list"))
	
})