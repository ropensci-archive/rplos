#' Search PLoS Journals abstracts.
#' 
#' @template plos
#' @return Abstract content, in addition to any other fields requested in a list.
#' @examples \dontrun{
#' plosabstract(q = 'drosophila', fl='abstract', limit=10)
#' plosabstract(q = 'drosophila', fl='id,author', limit = 5)
#' plosabstract(q = 'drosophila', fl='author', limit = 5)
#' plosabstract(q = 'drosophila', fl='id,author,title', limit = 5)
#' plosabstract(q = 'drosophila', fl='id,author,title', limit = 5, 
#'  callopts=list(verbose=TRUE))
#' 
#' # Highlighting
#' plosabstract(q='drosophila', fl='abstract', limit = 2, highlighting=TRUE)
#' }
#' @export

plosabstract <- function(q = NA, fl = 'id', fq = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, sleep = 6,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(q=paste('abstract:', '"', q, '"', sep=""), fl=fl, 
             fq=fq, sort=sort, highlighting=highlighting, start=start, 
             limit=limit, returndf=returndf, sleep=sleep, curl=curl, key=key, 
             callopts=callopts)
}