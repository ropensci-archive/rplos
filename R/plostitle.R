#' Search PLoS Journals titles.
#' 
#' @template plos
#' @return Titles, in addition to any other fields requested in a data.frame.
#' @examples \dontrun{
#' plostitle(q='drosophila', fl='title', limit=99)
#' plostitle(q='drosophila', fl='title,journal', limit=10)
#' plostitle(q='drosophila',  limit = 5)
#' 
#' # Highlighting
#' plostitle(q='drosophila',  limit = 5, highlighting=TRUE)
#' }
#' @export

plostitle <- function(q = NA, fl = 'id', fq = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(q=paste('title:', '"', q, '"', sep=""), ...)
}