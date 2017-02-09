#' Get short keys for journals to use in searching specific journals.
#'
#' @export
#' @return (character) journal name keys
#' @examples \dontrun{
#' journalnamekey()
#' }
journalnamekey <- function() {
  names <-
    jsonlite::fromJSON(utf8cont(GET(
      paste0(pbase(), "?q=*:*&rows=0&facet=true&facet.field=journal_key&wt=json")
    )), FALSE)
  x <- names$facet_counts$facet_fields[[1]]
  unlist(x[vapply(x, is.character, logical(1))])
}
