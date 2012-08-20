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
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (results = FALSE), or number of search 
#'    results plus the results themselves (results = TRUE).
#' @examples \dontrun{
#' plosabstract(terms = 'drosophila', 'abstract', 2, 'FALSE')
#' plosabstract('drosophila',  limit = 5, results = 'TRUE')
#' }
#' @export
plosabstract <- function(terms = NULL, fields = NULL, limit = NULL, results = FALSE, 
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., curl = getCurlHandle() ) 
{
	args <- compact(list(q = paste('abstract:', terms, sep=""), fl = fields, rows = limit,
											 wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	tt <- fromJSON(out)$response$docs
	names_ <- names(tt[[which.max(laply(tt, length))]])
	addmissing <- function(x){
		if(identical(names_[!names_ %in% names(x)], character(0))){x} else
			{
				xx <- rep("na", length(names_[!names_ %in% names(x)]))
				names(xx) <- names_[!names_ %in% names(x)]
				c(x, xx)
			}
	}
	tt_ <- llply(tt, addmissing)
	data.frame(do.call(rbind, tt_))
}