#' Search PLoS Journals titles.
#' 
#' @import httr plyr
#' @param terms search terms for article titles (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Number of search results (results = FALSE), or number of search 
#'    results plus the results themselves (results = TRUE).
#' @examples \dontrun{
#' plostitle(terms='drosophila', fields='title', limit=99)
#' plostitle(terms='drosophila',  limit = 5)
#' }
#' @export
plostitle <- function(terms, fields = NULL, limit = NULL,
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals"))) 
{
  args <- compact(list(q = paste('title:', terms, sep=""), fl = fields, 
											 rows = limit, wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	out2 <- out$response$docs
	out3 <- lapply(out2, concat_todf)
	do.call(rbind, out3)
}