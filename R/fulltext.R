#' Create urls for full text articles in PLOS journals.
#'
#' @export
#' @param doi One or more doi's
#' @return One or more urls, same length as input vector of dois
#' @details We give \strong{NA} for DOIs that are for annotations. Those can easily
#' be removed like \code{Filter(Negate(is.na), res)}
#' @examples \dontrun{
#' full_text_urls(doi='10.1371/journal.pone.0086169')
#' full_text_urls(doi='10.1371/journal.pbio.1001845')
#' full_text_urls(doi=c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
#' 
#' # contains some annotation DOIs
#' dois <- searchplos(q = "*:*", fq='doc_type:full', limit=20)$data$id
#' full_text_urls(dois)
#' 
#' # contains no annotation DOIs
#' dois <- searchplos(q = "*:*", fq=list('doc_type:full', 'article_type:"Research Article"'), 
#' limit=20)$data$id
#' full_text_urls(dois)
#' }

full_text_urls <- function(doi) {
  plos_check_dois(doi)
  makeurl <- function(x) {
    if (grepl("annotation", x)) {
      NA_character_
    } else {
      doijournal <- strsplit(x, "\\.")[[1]][[3]]
      journal <- switch(doijournal,
                        pone = 'plosone',
                        pbio = 'plosbiology',
                        pmed = 'plosmedicine',
                        pgen = 'plosgenetics',
                        pcbi = 'ploscompbiol',
                        ppat = 'plospathogens',
                        pntd = 'plosntds',
                        pctr = 'plosclinicaltrials')
      if ("plosclinicaltrials" == journal) {
        ub <- 'http://journals.plos.org/plosclinicaltrials/article/asset?id=%s.XML'
        sprintf(ub, x)
      } else {
        ub <- 'http://journals.plos.org/%s/article/file?id=%s&type=manuscript'
        sprintf(ub, journal, x)
      }
    }
  }
  vapply(doi, makeurl, "", USE.NAMES = FALSE)
}

#' Get full text xml of PLOS papers given a DOI
#'
#' @export
#' @param doi One or more DOIs
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @param x Input to print method
#' @return Character string of XML.
#' @examples \dontrun{
#' plos_fulltext(doi='10.1371/journal.pone.0086169')
#' plos_fulltext(c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
#' dois <- searchplos(q = "*:*", 
#'   fq = list('doc_type:full', 'article_type:"Research Article"'), 
#'   limit = 3)$data$id
#' out <- plos_fulltext(dois)
#' out[dois[1]]
#' out[1:2]
#'
#' # Extract text from the XML strings - xml2 package required
#' if (requireNamespace("xml2")) {
#'   library("xml2")
#'   lapply(out, function(x){
#'     tmp <- xml2::read_xml(x)
#'     xml2::xml_find_all(tmp, "//ref-list//ref")
#'   })
#' }
#' 
#' }
plos_fulltext <- function(doi, ...){
  urls <- full_text_urls(doi)
  getfulltext <- function(x){
    out <- httr::GET(x, ...)
    httr::warn_for_status(out)
    if (!out$headers$`content-type` %in% c('application/xml', 'text/xml')) {
      stop('content-type not one of "application/xml" or "text/xml"', call. = FALSE)
    }
    utf8cont(out)
  }
  res <- lapply(urls, getfulltext)
  names(res) <- doi
  class(res) <- "plosft"
  return( res )
}

#' @export
#' @rdname plos_fulltext
print.plosft <- function(x, ...){
  namesprint <- paste(stats::na.omit(names(x)[1:10]), collapse = " ")
  lengths <- vapply(x, nchar, 1, USE.NAMES = FALSE)
  cat(sprintf("%s full-text articles retrieved", length(x)), "\n")
  cat(sprintf("Min. Length: %s - Max. Length: %s", min(lengths), max(lengths)), "\n")
  cat(rplos_wrap(sprintf("DOIs:\n %s ...", namesprint)), "\n\n")
  cat("NOTE: extract xml strings like output['<doi>']")
}

rplos_wrap <- function(..., indent = 0, width = getOption("width")) {
  x <- paste0(..., collapse = "")
  wrapped <- strwrap(x, indent = indent, exdent = indent + 2, width = width)
  paste0(wrapped, collapse = "\n")
}
