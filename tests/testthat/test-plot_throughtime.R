context("plot_throughtime")

a <- plot_throughtime('phylogeny', 300, key = "hello")
b <- plot_throughtime(list('drosophila','monkey'), 100, key = "hello")
c <- plot_throughtime(list('drosophila','flower'), 100, key = "hello")

test_that("plot_throughtime returns the correct class", {
  expect_is(a, "ggplot")
  expect_is(b, "ggplot")
  expect_is(c, "ggplot")
  expect_is(a$data, "data.frame")
})