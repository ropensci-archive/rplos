#' Search PLoS Journals titles.
#' 
#' @template plos
#' @return Titles, in addition to any other fields requested in a data.frame.
#' @examples \dontrun{
#' plostitle(terms='drosophila', fields='title', limit=99)
#' plostitle(terms='drosophila', fields='title,journal', limit=10)
#' plostitle(terms='drosophila',  limit = 5)
#' 
#' # Highlighting
#' plostitle(terms='drosophila',  limit = 5, highlighting=TRUE)
#' }
#' @export

plostitle <- function(terms = NA, fields = 'id', toquery = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(terms=paste('title:', '"', terms, '"', sep=""), fields=fields, 
             toquery=toquery, sort=sort, highlighting=highlighting, start=start, 
             limit=limit, returndf=returndf, sleep=sleep, curl=curl, key=key, 
             callopts=callopts)
}