# tests for plot_throughtime fxn in rplos
context("plot_throughtime")

test_that("plot_throughtime returns the correct class", {
	expect_that(plot_throughtime('phylogeny', 100), is_a("ggplot"))
	expect_that(plot_throughtime(list('drosophila','monkey'), 100), is_a("ggplot"))
})