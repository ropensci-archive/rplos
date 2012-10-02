#' Search PLoS Journals abstracts.
#' 
#' @import httr plyr
#' @param terms search terms for article abstract (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param results print results or not (TRUE or FALSE)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Abstract content, in addition to any other fields requested in a data.frame.
#' @examples \dontrun{
#' plosabstract(terms = 'drosophila', fields='abstract', limit=10)
#' plosabstract(terms = 'drosophila', fields='author', limit = 5)
#' }
#' @export
plosabstract <- function(terms = NULL, fields = NULL, limit = NULL, 
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals"))) 
{
	args <- compact(list(q = paste('abstract:', terms, sep=""), fl = fields, 
											 rows = limit, wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	out2 <- out$response$docs
	out3 <- addmissing(out2)
	out4 <- lapply(out3, concat_todf)
	do.call(rbind, out4)
}