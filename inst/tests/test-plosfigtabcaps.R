# tests for plosfigtabcaps fxn in rplos
context("plosfigtabcaps")

test_that("plosfigtabcaps returns the correct dimenion result", {
	expect_that(nrow(plosfigtabcaps('ecology', 'figure_table_caption', 10)), 
							equals(10))
	expect_that(length(names(plosfigtabcaps('ecology', 'figure_table_caption', 10))), 
							equals(1))
	expect_that(names(plosfigtabcaps('ecology', 'figure_table_caption', 10)), 
							equals("figure_table_caption"))
	expect_that(names(plosfigtabcaps('ecology', 'id', 10)), 
							equals("id"))
})

test_that("plosfigtabcaps returns the correct class", {
	expect_that(class(plosfigtabcaps('ecology', 'figure_table_caption', 10)), 
							is_a("character"))
})