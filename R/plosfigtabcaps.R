#' Search PLoS Journals figure and table captions.
#' 
#' @import RJSONIO RCurl
#' @param terms search terms
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  	the returned value in here (avoids unnecessary footprint)
#' @return Fields that you specify to return in a data.frame, along with the 
#' 		DOI's found.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', 500)
#' plosfigtabcaps(terms='ecology', fields='figure_table_caption', limit=10)
#' }
#' @export
plosfigtabcaps <- function(terms, fields = NA, limit = NA,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., curl = getCurlHandle() ) 
{
	url = 'http://api.plos.org/search'
	
	args <- compact(list(q = paste('figure_table_caption:', terms, sep=""), fl = fields, 
	                     rows = limit, wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	out2 <- out$response$docs
	lapply(out2, function(x) lapply(x, trim))
}