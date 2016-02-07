#' Search PLOS Rich Citations API
#'
#' @export
#' @param uri (character) A URI, of the form \code{http://dx.doi.org/<DOI>}
#' @param doi (character) A PLOS journals DOI
#' @param random (integer) A number of random articles to get data for.
#' Default: NULL
#' @param parse (logical) Passed to \code{\link[jsonlite]{fromJSON}}, toggles
#' whether we return json parsed to data.frame's where possible, or not.
#' Default: FALSE
#' @param ... Curl options passed to \code{\link[httr]{GET}}
#' @return A list
#' @references \url{http://api.richcitations.org/}
#' @details To get an API key, email \email{ploslabs@@plos.org} and request a key
#' @examples \dontrun{
#' # get citations for an article (via its DOI)
#' uri <- "http://dx.doi.org/10.1371%2Fjournal.pone.0000000"
#' citations(uri)
#' citations(uri, parse = TRUE)
#'
#' # pass in a DOI, url encoded or not
#' citations(doi = "10.1371%2Fjournal.pone.0000000")
#' citations(doi = "10.1371/journal.pone.0000000")
#' ids <- searchplos(q='ecology', fl='id', limit = 20)$data$id
#' citations(doi = ids[1])
#'
#' # get citations for a random article
#' citations(random = 1)
#' }

citations <- function(uri = NULL, doi = NULL, random = NULL, parse = FALSE, ...) {
  # one has to be non-NULL
  stopifnot(length(ploscompact(list(uri, doi, random))) == 1)
  stopifnot(checknum(random))
  if (is.null(random)) uri <- uriparse(uri, doi)
  args <- ploscompact(list(uri = uri, random = random))
  if (length(args) == 0) args <- NULL
  res <- GET(richbase(), query = args, ...)
  stop_for_status(res)
  jsonlite::fromJSON(utf8cont(res), parse)
}

richbase <- function() "http://api.richcitations.org/papers"

checknum <- function(x) {
  if (is.null(x)) {
    TRUE
  } else {
    is.numeric(x)
  }
}

uriparse <- function(x, y) {
  # both can't be null
  stopifnot(xor(!is.null(x), !is.null(y)))
  # check for url encoding
  if (!is.null(y)) {
    paste0("http://dx.doi.org/", sub("/", "%2F", y))
  } else {
    x
  }
}
