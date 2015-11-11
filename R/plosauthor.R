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
  start = 0, limit = 10,
  sleep = 6, terms=NULL, fields=NULL, toquery=NULL, callopts=NULL, ...)
{
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- c("terms", "fields", "toquery", "callopts") %in% calls
  if(any(calls_vec))
    stop("The parameters terms, fields, toquery, and callopts replaced with q, fl, fq, ..., respectively")

	searchplos(q=paste('author:', '"', q, '"', sep=""), fl=fl, fq=fq,
	           sort=sort, start=start, limit=limit,
	           sleep=sleep, ...)
}
