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
  start = 0, limit = 10, sleep = 6, errors = "simple",
  proxy = NULL, callopts=NULL, ...) {

	searchplos(q=paste('author:', '"', q, '"', sep=""), fl=fl, fq=fq,
	           sort=sort, start=start, limit=limit,
	           sleep=sleep, errors = errors,
	           proxy = proxy, callopts = callopts, ...)
}
