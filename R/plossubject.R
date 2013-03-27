#' Search PLoS Journals subjects.
#' 
#' @import httr plyr
#' @param terms Search terms for article subjects (character)
#' @param fields Fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param toquery Specific fields to query (if NA, all queried), in a comma 
#' 		separated string (character) [e.g., 'doc_type:full,year=2010'].
#' @param limit Number of results to return (integer)
#' @param key Your PLoS API key, either enter, or loads from .Rprofile
#' @return Subject content, in addition to any other fields requested in a data.frame.
#' @details See \url{http://www.plosone.org/taxonomy} for subject areas.
#' @export
#' @examples \dontrun{
#' plossubject('marine ecology', limit = 5)[,1:4]
#' plossubject(terms='marine ecology',  fields = 'id,journal', limit = 20)
#' plossubject('museums', fields = 'id,journal', toquery='doc_type:full', limit = 9)
#' plossubject(terms='marine ecology', fields = 'id,journal', toquery=list('doc_type:full','!article_type_facet:"Issue%20Image"'), limit = 9)
#' }
plossubject <- function(terms, fields = NULL, limit = NULL, toquery = NULL,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals"))) 
{
	url = 'http://api.plos.org/search'
	
# 	if(!is.null(toquery))
# 		names(toquery) <- rep('fq', length(toquery))	
	args <- compact(list(q = paste('subject:', '"', terms, '"', sep=""), 
											 fq = paste(toquery, collapse = " AND ", sep=" "),
											 fl = fields, rows = limit, wt = "json", apikey = key))
# 	args <- c(args, toquery)
	
	out <- content(GET(url, query = args))
	out2 <- out$response$docs
	out3 <- addmissing(out2)
	out4 <- lapply(out3, concat_todf)
	do.call(rbind, out4)
}