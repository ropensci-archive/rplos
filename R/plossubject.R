#' Search PLoS Journals subjects.
#' 
#' @import httr plyr
#' @param terms search terms for article subjects (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Subject content, in addition to any other fields requested in a data.frame.
#' @export
#' @examples \dontrun{
#' plossubject(terms = 'ecology', fields = 'subject', limit = 9)
#' plossubject('ecology',  limit = 5)
#' plossubject('ecology',  fields = 'abstract', limit = 20)
#' }
plossubject <- function(terms, fields = NULL, limit = NULL, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals"))) 
{
	url = 'http://api.plos.org/search'
	
# 	args <- compact(list(q = paste('subject:', terms, sep=""), fl = fields,
	args <- compact(list(q = terms, fl = fields, rows = limit, wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	out2 <- out$response$docs
	out3 <- addmissing(out2)
	out4 <- lapply(out3, concat_todf)
	do.call(rbind, out4)
}