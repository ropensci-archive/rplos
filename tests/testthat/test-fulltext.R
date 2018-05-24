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

test_that("full_text_urls - NA's on annotation DOIs", {
  vcr::use_cassette("full_text_urls-with-searchplos", {
    dois <- searchplos(q = "*:*", fq = 'doc_type:full', limit = 20)$data$id
    aa <- full_text_urls(dois)

    expect_is(dois, "character")
    expect_is(aa, "character")
  })
})

test_that("plos_fulltext works", {
  vcr::use_cassette("full_text_urls-with-searchplos2", {
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
  }, preserve_exact_body_bytes = TRUE)
})

test_that("plos_fulltext works with all journals", {
  skip_on_cran()

  doi_pone1 <- '10.1371/journal.pone.0165447'
  doi_pone2 <- '10.1371/journal.pone.0111629'
  doi_pbio1 <- '10.1371/journal.pbio.2000225'
  doi_pbio2 <- '10.1371/journal.pbio.2000106'
  doi_pmed1 <- '10.1371/journal.pmed.1002175'
  doi_pmed2 <- '10.1371/journal.pmed.1001443'
  doi_pgen1 <- '10.1371/journal.pgen.1005936'
  doi_pgen2 <- '10.1371/journal.pgen.1006440'
  doi_pcbi1 <- '10.1371/journal.pcbi.1005155'
  doi_pcbi2 <- '10.1371/journal.pcbi.1005201'
  doi_ppat1 <- '10.1371/journal.ppat.1005983'
  doi_ppat2 <- '10.1371/journal.ppat.1000799'
  doi_pntd1 <- '10.1371/journal.pntd.0004494'
  doi_pntd2 <- '10.1371/journal.pntd.0005087'
  doi_pctr1 <- '10.1371/journal.pctr.0020026'
  doi_pctr2 <- '10.1371/journal.pctr.0020020'

  pone1 <- plos_fulltext(doi = doi_pone1)
  pone2 <- plos_fulltext(doi = doi_pone2)
  pbio1 <- plos_fulltext(doi = doi_pbio1)
  pbio2 <- plos_fulltext(doi = doi_pbio2)
  pmed1 <- plos_fulltext(doi = doi_pmed1)
  pmed2 <- plos_fulltext(doi = doi_pmed2)
  pgen1 <- plos_fulltext(doi = doi_pgen1)
  pgen2 <- plos_fulltext(doi = doi_pgen2)
  pcbi1 <- plos_fulltext(doi = doi_pcbi1)
  pcbi2 <- plos_fulltext(doi = doi_pcbi2)
  ppat1 <- plos_fulltext(doi = doi_ppat1)
  ppat2 <- plos_fulltext(doi = doi_ppat2)
  pntd1 <- plos_fulltext(doi = doi_pntd1)
  pntd2 <- plos_fulltext(doi = doi_pntd2)
  pctr1 <- plos_fulltext(doi = doi_pctr1)
  pctr2 <- plos_fulltext(doi = doi_pctr2)

  expect_is(pone1, "plosft")
  expect_is(pone1[[1]], "character")
  expect_equal(length(pone1), 1)
  expect_match(pone1[[1]], "xml")
  expect_match(pone1[[1]], doi_pone1)

  expect_is(pone2, "plosft")
  expect_is(pone2[[1]], "character")
  expect_equal(length(pone2), 1)
  expect_match(pone2[[1]], "xml")
  expect_match(pone2[[1]], doi_pone2)


  expect_is(pbio1, "plosft")
  expect_is(pbio1[[1]], "character")
  expect_equal(length(pbio1), 1)
  expect_match(pbio1[[1]], "xml")
  expect_match(pbio1[[1]], doi_pbio1)

  expect_is(pbio2, "plosft")
  expect_is(pbio2[[1]], "character")
  expect_equal(length(pbio2), 1)
  expect_match(pbio2[[1]], "xml")
  expect_match(pbio2[[1]], doi_pbio2)


  expect_is(pmed1, "plosft")
  expect_is(pmed1[[1]], "character")
  expect_equal(length(pmed1), 1)
  expect_match(pmed1[[1]], "xml")
  expect_match(pmed1[[1]], doi_pmed1)

  expect_is(pmed2, "plosft")
  expect_is(pmed2[[1]], "character")
  expect_equal(length(pmed2), 1)
  expect_match(pmed2[[1]], "xml")
  expect_match(pmed2[[1]], doi_pmed2)


  expect_is(pgen1, "plosft")
  expect_is(pgen1[[1]], "character")
  expect_equal(length(pgen1), 1)
  expect_match(pgen1[[1]], "xml")
  expect_match(pgen1[[1]], doi_pgen1)

  expect_is(pgen2, "plosft")
  expect_is(pgen2[[1]], "character")
  expect_equal(length(pgen2), 1)
  expect_match(pgen2[[1]], "xml")
  expect_match(pgen2[[1]], doi_pgen2)


  expect_is(pcbi1, "plosft")
  expect_is(pcbi1[[1]], "character")
  expect_equal(length(pcbi1), 1)
  expect_match(pcbi1[[1]], "xml")
  expect_match(pcbi1[[1]], doi_pcbi1)

  expect_is(pcbi2, "plosft")
  expect_is(pcbi2[[1]], "character")
  expect_equal(length(pcbi2), 1)
  expect_match(pcbi2[[1]], "xml")
  expect_match(pcbi2[[1]], doi_pcbi2)


  expect_is(ppat1, "plosft")
  expect_is(ppat1[[1]], "character")
  expect_equal(length(ppat1), 1)
  expect_match(ppat1[[1]], "xml")
  expect_match(ppat1[[1]], doi_ppat1)

  expect_is(ppat2, "plosft")
  expect_is(ppat2[[1]], "character")
  expect_equal(length(ppat2), 1)
  expect_match(ppat2[[1]], "xml")
  expect_match(ppat2[[1]], doi_ppat2)


  expect_is(pntd1, "plosft")
  expect_is(pntd1[[1]], "character")
  expect_equal(length(pntd1), 1)
  expect_match(pntd1[[1]], "xml")
  expect_match(pntd1[[1]], doi_pntd1)

  expect_is(pntd2, "plosft")
  expect_is(pntd2[[1]], "character")
  expect_equal(length(pntd2), 1)
  expect_match(pntd2[[1]], "xml")
  expect_match(pntd2[[1]], doi_pntd2)


  expect_is(pctr1, "plosft")
  expect_is(pctr1[[1]], "character")
  expect_equal(length(pctr1), 1)
  expect_match(pctr1[[1]], "xml")
  expect_match(pctr1[[1]], doi_pctr1)

  expect_is(pctr2, "plosft")
  expect_is(pctr2[[1]], "character")
  expect_equal(length(pctr2), 1)
  expect_match(pctr2[[1]], "xml")
  expect_match(pctr2[[1]], doi_pctr2)
})

test_that("plos_fulltext fails well", {
  expect_error(plos_fulltext(), "argument \"doi\" is missing")
  expect_error(plos_fulltext("adfaf"), "These are probably not DOIs")
})
