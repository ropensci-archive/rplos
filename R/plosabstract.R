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
#' @return Abstract content in a list, named by their DOIs to facilitate further
#' 		research on each paper.
#' @examples \dontrun{
#' plosabstract(terms = 'drosophila', fields='abstract', limit=10)
#' plosabstract(terms = 'drosophila', fields='materials_and_methods', limit = 5)
#' }
#' @export
plosabstract <- function(terms = NULL, fields = NULL, limit = NULL, 
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals"))) 
{
	args <- compact(list(q = paste('abstract:', terms, sep=""), fl = fields, rows = limit,
											 wt = "json", apikey = key))
	out <- content(GET(url, query = args))
	abstracts <- out[[2]]$docs
	names(abstracts) <- names(out[[4]])
	sapply(abstracts, function(x) str_trim(gsub("\n|\t|\\s{9}", "", x), "both"))
# 	names_ <- names(out[[which.max(laply(out, length))]])
# 	addmissing <- function(x){
# 		if(identical(names_[!names_ %in% names(x)], character(0))){x} else
# 			{
# 				xx <- rep("na", length(names_[!names_ %in% names(x)]))
# 				names(xx) <- names_[!names_ %in% names(x)]
# 				c(x, xx)
# 			}
# 	}
}