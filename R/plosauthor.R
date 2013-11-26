#' Search PLoS Journals authors.
#' 
#' @template plos
#' @return Author names, in addition to any other fields requested in a 
#'    data.frame.
#' @examples \dontrun{
#' plosauthor('Smith', 'id', limit=50)
#' plosauthor(q='Smith', fl='id,author', limit=10)
#' 
#' # Highlighting
#' plosauthor(q='Jones', fl='author', limit = 2, highlighting=TRUE)
#' }
#' @export

plosauthor <- function(q = NA, fl = 'id', fq = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list(), ...)
{
	searchplos(q=paste('author:', '"', q, '"', sep=""), ...)
}