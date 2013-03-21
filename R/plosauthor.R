#' Search PLoS Journals authors.
#' 
#' @import httr plyr
#' @param terms authors to search for (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Author names, in addition to any other fields requested in a data.frame.
#' @export
#' @examples \dontrun{
#' plosauthor(terms = 'johnson', fields = 'title,author', limit = 100)
#' plosauthor('johnson',  limit = 5)
#' plosauthor('johnson',  'title', limit = 5)
#' }
plosauthor <- function(terms, fields = NULL, limit = NULL,
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals"))) 
{
	args <- compact(list(q = paste('author:', terms, sep=""), fl = fields, 
											 rows = limit, wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	out2 <- out$response$docs
	out3 <- lapply(out2, concat_todf)
	do.call(rbind, out3)
}