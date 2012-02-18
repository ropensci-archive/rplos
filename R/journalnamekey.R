#' Get short keys for journals to use in searching specific journals.
#' @import XML
#' @return List of journals and their keys.
#' @export
#' @examples \dontrun{
#' journalnamekey()
#' }
journalnamekey <- 

function()
{
  names <- xmlToList(
    getURL(
      "http://api.plos.org/search/?q=*:*&rows=0&fl=id,cross_published_journal_key&facet=true&facet.field=cross_published_journal_key"
    )
  )[[3]][[2]][seq(2,18,2)]
  as.character(names)
}