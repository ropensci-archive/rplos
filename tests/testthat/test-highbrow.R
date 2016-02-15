# tests for highbrow fxn in rplos
context("highbrow")

test_that("highbrow", {
  skip_on_cran()
  
  out <- highplos(q = 'alcohol', hl.fl = 'abstract', rows = 10, verbose = FALSE)
  aa <- highbrow(out, browse = FALSE)

  expect_is(out, "list")
  expect_is(aa, "character")
  expect_match(aa, ".html")
  
  # output parameter works
  ff <- tempfile(pattern = "fart", fileext = ".html")
  bb <- highbrow(out, output = ff, browse = FALSE)
  
  expect_is(bb, "character")
  expect_match(bb, "fart")
  
  # fails well
  expect_error(highbrow(), "Please supply some input")
  expect_error(highbrow("adf"), "Please supply a list object")
  
  alist <- list(a = 6, b = 5)
  expect_error(highbrow(alist), "These are probably not DOIs")
})
