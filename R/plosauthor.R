#' Search PLoS Journals authors.
#' 
#' @template plos
#' @return Author names, in addition to any other fields requested in a 
#'    data.frame.
#' @examples \dontrun{
#' plosauthor('Smith', 'id', limit=50)
#' plosauthor('Smith', 'figure_table_caption', limit=10)
#' 
#' # Highlighting
#' plosauthor(terms='Jones', fields='figure_table_caption', limit = 2, highlighting=TRUE)
#' }
#' @export

plosauthor <- function(terms = NA, fields = 'id', toquery = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(terms=paste('author:', '"', terms, '"', sep=""), fields=fields, 
             toquery=toquery, sort=sort, highlighting=highlighting, start=start, 
             limit=limit, returndf=returndf, sleep=sleep, curl=curl, key=key, 
             callopts=callopts)
}