# tests for searchplos fxn in rplos
context("citations")

test_that("citations", {
  skip_on_cran()

  # get citations for an article (via its DOI)
  uri <- "http://dx.doi.org/10.1371%2Fjournal.pone.0000000"
  a <- citations(uri)
  b <- citations(uri, parse = TRUE)

  # pass in a DOI, url encoded or not
  c <- citations(doi = "10.1371%2Fjournal.pone.0000000")
  d <- citations(doi = "10.1371/journal.pone.0000000")
  ids <- searchplos(q = 'ecology', fl = 'id', limit = 20)$data$id
  e <- citations(doi = ids[1])

  # get citations for a random article
  f <- citations(random = 1)

  # citations returns the correct classes
  expect_is(a, "list")
  expect_is(a$uri, "character")
	expect_is(a$bibliographic, "list")
  expect_is(a$references, "list")
  expect_is(a$citation_groups, "list")
  expect_is(b$references, "data.frame")
  expect_is(c, "list")
  expect_is(d, "list")
  expect_is(e, "list")

  # citations works with uri escaped DOIs and those not escaped
  expect_equal(c, d)

  # citations fails well
  expect_error(citations(), "is not TRUE")
  expect_error(citations(uri = 5), "Not Found")
  expect_error(citations(doi = 5), "Not Found")
})
