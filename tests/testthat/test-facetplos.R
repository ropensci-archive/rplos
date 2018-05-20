# tests for facetplos fxn in rplos
context("facetplos")

test_that("facetplos", {
  vcr::use_cassette("facetplos", {
    # Facet on a single field
    aa <- facetplos(q='*:*', facet.field='journal')

    # Facet on multiple fields
    bb <- facetplos(q='alcohol', facet.field=c('journal','subject'))

    # Using mincount
    cc <- facetplos(q='alcohol', facet.field='journal', facet.mincount='500')

    # Using facet.query to get counts
    ## Many facet.query terms
    dd <- facetplos(q='*:*', facet.field='journal', facet.query='cell,bird')


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
    expect_lt(NROW(cc$facet_fields$journal), NROW(aa$facet_fields$journal))

    expect_is(dd, "list")
    expect_is(dd$facet_queries, "data.frame")
    expect_is(dd$facet_fields, "list")
    expect_is(dd$facet_fields[[1]], "data.frame")
    expect_named(dd$facet_fields, 'journal')
  })
})

test_that("facetplos fails well", {
  vcr::use_cassette("facetplos-failswell", {
    expect_error(facetplos(), "didn't detect any facet. fields")
    expect_error(facetplos("*:*", facet.field = "adsfad"),
                 "400 - undefined field")
  })
})
