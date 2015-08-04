# tests for highplos fxn in rplos
context("highplos")

test_that("highplos", {
  skip_on_cran()

  aa <- highplos(q='alcohol', hl.fl = 'abstract', rows=10, verbose = FALSE)
  bb <- highplos(q='everything:"sports alcohol"~7', hl.fl='everything', verbose = FALSE)
  cc <- highplos(q='alcohol', hl.fl='abstract', hl.fragsize=20, rows=5, verbose = FALSE)
  dd <- highplos(q='alcohol', hl.fl='abstract', hl.snippets=5, hl.mergeContiguous='true', rows=5, verbose = FALSE)

  # citations returns the correct classes
  expect_is(aa, "list")
  expect_is(aa[[1]], "list")
  expect_is(aa[[1]][[1]], "character")
  expect_is(aa, "list")
  ## has em tags
  expect_true(grepl("\\<em\\>", aa[[1]][[1]]))

  expect_is(bb, "list")
  expect_is(bb[[1]], "list")
  expect_is(bb[[1]][[1]], "character")
  expect_named(bb[[1]], "everything")

  expect_is(cc, "list")
  expect_is(cc[[1]], "list")
  expect_is(cc[[1]][[1]], "character")
  expect_named(cc[[1]], "abstract")
  expect_equal(length(cc), 5)

  expect_is(dd, "list")
  expect_is(dd[[1]], "list")
  expect_is(dd[[1]][[1]], "character")
  ## character strings are longer than result from cc call
  expect_more_than(nchar(dd[[1]][[1]]), nchar(cc[[1]][[1]]))

  # fails well
  expect_error(length(highplos(verbose = FALSE)), "\"q\" is missing, with no default")
  expect_equal(length(highplos("*:*", verbose = FALSE)[[1]]), 0)
  expect_error(highplos("alcohol", hl.fragsize = "adsfad", verbose = FALSE), "Bad Request")
  expect_error(highplos("alcohol", hl.snippets = "adsfad", verbose = FALSE), "Bad Request")
})
