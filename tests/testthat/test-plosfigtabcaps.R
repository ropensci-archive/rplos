# tests for plosfigtabcaps fxn in rplos
context("plosfigtabcaps")

dat <- plosfigtabcaps(q='ecology', fl='figure_table_caption', limit=10, key = "hello")

test_that("plosfigtabcaps returns the correct dimenion result", {
	expect_that(nrow(dat), equals(10))
	expect_that(length(names(dat)), equals(1))
	expect_that(names(dat), equals("figure_table_caption"))
	expect_that(names(plosfigtabcaps(q='ecology', fl='id', limit=10, key = "hello")), 
							equals("id"))
})

test_that("plosfigtabcaps returns the correct class", {
	expect_that(class(dat), is_a("character"))
})