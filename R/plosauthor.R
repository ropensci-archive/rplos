#' Search PLoS Journals authors.
#' 
#' @template plos
#' @return Author names, in addition to any other fields requested in a 
#'    data.frame.
#' @examples \dontrun{
#' plosauthor('Smith', 'id', limit=50)
#' plosauthor(q='Smith', fl='id,author', limit=10)
#' }
#' @export

plosauthor <- function(q = NA, fl = 'id', fq = NA, sort = NA,
  start = 0, limit = NA, key = NULL, 
  sleep = 6, callopts=list(), terms, fields, toquery)
{
  calls <- deparse(sys.calls())
  calls_vec <- sapply(c("terms", "fields", "toquery"), function(x) grepl(x, calls))
  if(any(calls_vec))
    stop("The parameters terms, fields, and toquery have been replaced with q, fl, and fq, respectively")
  
	searchplos(q=paste('author:', '"', q, '"', sep=""), fl=fl, fq=fq,
	           sort=sort, start=start, limit=limit,
	           key=key, sleep=sleep, callopts=callopts)
}