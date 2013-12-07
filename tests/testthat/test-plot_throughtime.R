context("plot_throughtime")

a <- plot_throughtime('phylogeny', 300)
b <- plot_throughtime(list('drosophila','monkey'), 100)
c <- plot_throughtime(list('drosophila','flower'), 100, TRUE)

test_that("plot_throughtime returns the correct class", {
  expect_is(a, "ggplot")
  expect_is(b, "ggplot")
  expect_is(c, "character")
  expect_is(a$data, "data.frame")
})