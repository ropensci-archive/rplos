#' Get short keys for journals to use in searching specific journals.
#'
#' @return Journals name keys.
#' @export
#' @examples \dontrun{
#' journalnamekey()
#' }
journalnamekey <- function() {
  names <-
    jsonlite::fromJSON(utf8cont(GET(
      paste0(pbase(), "?q=*:*&rows=0&fl=id,cross_published_journal_key&facet=true&facet.field=cross_published_journal_key&wt=json")
    )), FALSE)
  temp <- names$facet_counts$facet_fields[[1]][sapply(names$facet_counts$facet_fields[[1]], is.character)]
  do.call(c, temp)
}
