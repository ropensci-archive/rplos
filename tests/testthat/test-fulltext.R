# tests for fulltext fxns in rplos
context("fulltext")

test_that("full_text_urls", {
  skip_on_cran()
  
  aa <- full_text_urls(doi = '10.1371/journal.pone.0086169')
  bb <- full_text_urls(doi = '10.1371/journal.pbio.1001845')
  cc <- full_text_urls(doi = c('10.1371/journal.pone.0086169', '10.1371/journal.pbio.1001845'))
  
  # citations returns the correct classes
  expect_is(aa, "character")
  expect_is(bb, "character")
  expect_is(cc, "character")
  
  expect_equal(length(aa), 1)
  expect_equal(length(bb), 1)
  expect_equal(length(cc), 2)
  
  expect_match(aa, "plosone")
  expect_match(bb, "plosbiology")
  
  # fails well
  expect_error(full_text_urls(), "argument \"doi\" is missing")
  expect_error(full_text_urls("adfaf"), "These are probably not DOIs")
})

test_that("plos_fulltext", {
  skip_on_cran()
  
  aa <- plos_fulltext(doi = '10.1371/journal.pone.0086169')
  bb <- plos_fulltext(c('10.1371/journal.pone.0086169', '10.1371/journal.pbio.1001845'))
  dois <- searchplos(q = "*:*", fq = list('doc_type:full', 'article_type:"Research Article"'), limit = 3)$data$id
  cc <- plos_fulltext(dois)
  
  # citations returns the correct classes
  expect_is(aa, "plosft")
  expect_is(bb, "plosft")
  expect_is(cc, "plosft")
  
  expect_is(aa[[1]], "character")
  expect_is(bb[[1]], "character")
  expect_is(bb[[2]], "character")
  expect_is(cc[[2]], "character")
  
  expect_equal(length(aa), 1)
  expect_equal(length(bb), 2)
  expect_equal(length(cc), 3)
  
  # fails well
  expect_error(plos_fulltext(), "argument \"doi\" is missing")
  expect_error(plos_fulltext("adfaf"), "These are probably not DOIs")
})
