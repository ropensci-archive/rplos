#' Get short keys for journals to use in searching specific journals.
#'
#' @export
#' @param ... optional curl options passed to \code{\link[crul]{HttpClient}}
#' @return (character) journal name keys
#' @examples \dontrun{
#' journalnamekey()
#' }
journalnamekey <- function(...) {
  cli <- HttpClient$new(url = pbase())
  out <- cli$get(query = list(q = "*:*", rows = 0, facet = "true", 
                              facet.field = "journal_key", wt = "json"), ...)
  out$raise_for_status()
  names <- jsonlite::fromJSON(out$parse("UTF-8"), FALSE)
  x <- names$facet_counts$facet_fields[[1]]
  unlist(x[vapply(x, is.character, logical(1))])
}
