# tests for highplos fxn in rplos
context("highplos")

test_that("highplos", {
  vcr::use_cassette("highplos", {
    aa <- highplos(q='alcohol', hl.fl = 'abstract', rows=10)
    bb <- highplos(q='everything:"sports alcohol"~7', hl.fl='everything')
    cc <- highplos(q='alcohol', hl.fl='abstract', hl.fragsize=20, rows=5)
    dd <- highplos(q='alcohol', hl.fl='abstract', hl.snippets=5,
                   hl.mergeContiguous='true', rows=5)

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
    expect_gt(nchar(dd[[1]][[1]][[1]]), nchar(cc[[1]][[1]]))
  }, preserve_exact_body_bytes = TRUE)
})

test_that("highplos fails well", {
  vcr::use_cassette("highplos_errors", {
    # fails well
    expect_error(length(highplos()),
                 "\"q\" is missing, with no default")
    expect_equal(length(highplos("*:*")[[1]]), 0)
    expect_error(highplos("alcohol", hl.fragsize = "adsfad"),
                 "400 - For input string")
    expect_error(highplos("alcohol", hl.snippets = "adsfad"),
                 "400 - For input string")
  }, preserve_exact_body_bytes = TRUE)
})
