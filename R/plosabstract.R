#' Search PLoS Journals abstracts.
#' 
#' @template plos
#' @return Abstract content, in addition to any other fields requested in a list.
#' @examples \dontrun{
#' plosabstract(terms = 'drosophila', fields='abstract', limit=10)
#' plosabstract(terms = 'drosophila', fields='id,author', limit = 5)
#' plosabstract(terms = 'drosophila', fields='id,author,title', limit = 5)
#' plosabstract(terms = 'drosophila', fields='id,author,title', limit = 5, 
#'  callopts=list(verbose=TRUE))
#' 
#' # Highlighting
#' plosabstract(terms='drosophila', fields='abstract', limit = 2, highlighting=TRUE)
#' }
#' @export

plosabstract <- function(terms = NA, fields = 'id', toquery = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, sleep = 6,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(terms=paste('abstract:', '"', terms, '"', sep=""), fields=fields, 
             toquery=toquery, sort=sort, highlighting=highlighting, start=start, 
             limit=limit, returndf=returndf, sleep=sleep, curl=curl, key=key, 
             callopts=callopts)
}