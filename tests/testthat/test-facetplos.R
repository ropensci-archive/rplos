# tests for facetplos fxn in rplos
context("facetplos")

test_that("facetplos", {
  skip_on_cran()

  # Facet on a single field
  aa <- facetplos(q='*:*', facet.field='journal', verbose=FALSE)

  # Facet on multiple fields
  bb <- facetplos(q='alcohol', facet.field=c('journal','subject'), verbose=FALSE)

  # Using mincount
  cc <- facetplos(q='alcohol', facet.field='journal', facet.mincount='500', verbose=FALSE)

  # Using facet.query to get counts
  ## Many facet.query terms
  dd <- facetplos(q='*:*', facet.field='journal', facet.query='cell,bird', verbose=FALSE)

  # Date faceting
  ee <- facetplos(q='*:*', url=url, facet.date='publication_date',
   facet.date.start='NOW/DAY-5DAYS', facet.date.end='NOW', facet.date.gap='+1DAY', verbose=FALSE)

  # citations returns the correct classes
  expect_is(aa, "list")
  expect_null(aa$facet_queries)
  expect_is(aa$facet_fields, "list")
  expect_is(aa$facet_fields[[1]], "data.frame")

  expect_is(bb, "list")
  expect_null(bb$facet_queries)
  expect_is(bb$facet_fields, "list")
  expect_is(bb$facet_fields[[1]], "data.frame")
  expect_is(bb$facet_fields[[2]], "data.frame")
  expect_named(bb$facet_fields, c('journal', 'subject'))

  expect_is(cc, "list")
  expect_null(cc$facet_queries)
  expect_is(cc$facet_fields, "list")
  expect_is(cc$facet_fields[[1]], "data.frame")
  expect_named(cc$facet_fields, 'journal')
  expect_less_than(NROW(cc$facet_fields$journal), NROW(aa$facet_fields$journal))

  expect_is(dd, "list")
  expect_is(dd$facet_queries, "data.frame")
  expect_is(dd$facet_fields, "list")
  expect_is(dd$facet_fields[[1]], "data.frame")
  expect_named(dd$facet_fields, 'journal')

  expect_is(ee, "list")
  expect_null(ee$facet_queries)
  expect_null(ee$facet_ranges)
  expect_null(ee$facet_fields)
  expect_is(ee$facet_dates[[1]], "data.frame")
  expect_is(as.Date(ee$facet_dates[[1]]$date), 'Date')

  # fails well
  expect_equal(length(ploscompact(facetplos(verbose = FALSE))), 0)
  expect_null(facetplos("*:*", url = "adsfad", verbose = FALSE)[[1]])
  expect_error(facetplos("*:*", facet.field = "adsfad", verbose = FALSE), "Bad Request")
})
