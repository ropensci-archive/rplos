#' Search PLoS Journals authors.
#' 
#' @export
#' @template plos
#' @return Author names, in addition to any other fields requested in a 
#'    data.frame.
#' @examples \dontrun{
#' plosauthor('Smith', 'id', limit=50)
#' plosauthor(q='Smith', fl=c('id','author'), limit=10)
#' }

plosauthor <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL,
  start = 0, limit = 10, key = NULL, 
  sleep = 6, callopts=list(), terms=NULL, fields=NULL, toquery=NULL)
{
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- c("terms", "fields", "toquery") %in% calls
  if(any(calls_vec))
    stop("The parameters terms, fields, and toquery have been replaced with q, fl, and fq, respectively")
  
	searchplos(q=paste('author:', '"', q, '"', sep=""), fl=fl, fq=fq,
	           sort=sort, start=start, limit=limit,
	           key=key, sleep=sleep, callopts=callopts)
}