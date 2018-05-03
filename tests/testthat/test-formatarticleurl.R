# tests for formatarticleurl fxn in rplos
context("formatarticleurl")

test_that("formatarticleurl returns the correct value", {
	expect_that(formatarticleurl("10.1371/journal.pone.0004045", 'PLoSONE'),
							equals("http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0004045"))
})

test_that("formatarticleurl returns the correct class", {
	expect_that(formatarticleurl("10.1371/journal.pone.0004045", 'PLoSONE'), is_a("character"))
})
