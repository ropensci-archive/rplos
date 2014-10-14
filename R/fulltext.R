#' Create urls for full text articles in PLOS journals.
#'
#' @export
#' @param doi One or more doi's
#' @return One or more urls, same length as input vector of dois
#' @examples \dontrun{
#' full_text_urls(doi='10.1371/journal.pone.0086169')
#' full_text_urls(doi='10.1371/journal.pbio.1001845')
#' full_text_urls(doi=c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
#' dois <- searchplos(q = "*:*", fq='doc_type:full', limit=20)$id
#' full_text_urls(dois)
#' }

full_text_urls <- function(doi){
  makeurl <- function(x){
    doijournal <- strsplit(x, "\\.")[[1]][[3]]
    journal <- switch(doijournal,
                      pone = 'plosone',
                      pbio = 'plosbiology',
                      pmed = 'plosmedicine',
                      pgen = 'plosgenetics',
                      pcbi = 'ploscompbiol',
                      ppat = 'plospathogens',
                      pntd = 'plosntds')
    ub <- 'http://www.%s.org/article/fetchObject.action?uri=info:doi/%s&representation=XML'
    sprintf(ub, journal, x)
  }
  vapply(doi, makeurl, "", USE.NAMES = FALSE)
}

#' Get full text xml of PLOS papers given a DOI
#'
#' @export
#' @param doi One or more DOIs
#' @param callopts Curl options passed on to httr::GET
#' @return Character string of XML.
#' @examples \dontrun{
#' plos_fulltext(doi='10.1371/journal.pone.0086169')
#' plos_fulltext(c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
#' dois <- searchplos(q = "*:*", fq='doc_type:full', limit=3)$data$id
#' out <- plos_fulltext(dois)
#' out[dois[1]]
#' out[1:2]
#'
#' # Extract text from the XML strings
#' library("XML")
#' lapply(out[2:3], function(x){
#'  tmp <- xmlParse(x)
#'  xpathApply(tmp, "//ref-list")
#' })
#'
#' # Make a text corpus
#' library("tm")
#' out_parsed <- lapply(out, function(x){
#'  tmp <- xmlParse(x)
#'  xpathApply(tmp, "//body", xmlValue)
#' })
#' tmcorpus <- Corpus(VectorSource(out_parsed))
#' (dtm <- DocumentTermMatrix(tmcorpus))
#' findFreqTerms(dtm, lowfreq = 50)
#' }
plos_fulltext <- function(doi, callopts=list()){
  urls <- full_text_urls(doi)
  getfulltext <- function(x){
    out <- GET(x, list(), callopts)
    warn_for_status(out)
    assert_that(out$headers$`content-type` == 'text/xml')
    content(out, as = "text")
  }
  res <- lapply(urls, getfulltext)
  names(res) <- doi
  class(res) <- "plosft"
  return( res )
}

#' @export
#' @param x Input, of class plosft
#' @param ... Further args, ignored
#' @rdname plos_fulltext
print.plosft <- function(x, ...){
  namesprint <- paste(na.omit(names(x)[1:10]), collapse = " ")
  lengths <- vapply(x, nchar, 1, USE.NAMES = FALSE)
  cat(sprintf("%s full-text articles retrieved", length(x)), "\n")
  cat(sprintf("Min. Length: %s - Max. Length: %s", min(lengths), max(lengths)), "\n")
  cat(rplos_wrap(sprintf("DOIs:\n %s ...", namesprint)), "\n\n")
  cat("NOTE: extract xml strings like output['<doi>']")
}

rplos_wrap <- function (..., indent = 0, width = getOption("width")){
  x <- paste0(..., collapse = "")
  wrapped <- strwrap(x, indent = indent, exdent = indent + 2, width = width)
  paste0(wrapped, collapse = "\n")
}
