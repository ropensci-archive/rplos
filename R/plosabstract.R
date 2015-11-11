#' Search PLoS Journals abstracts.
#'
#' @export
#' @template plos
#' @return Abstract content, in addition to any other fields requested in a list.
#' @examples \dontrun{
#' plosabstract(q = 'drosophila', fl='abstract', limit=10)
#' plosabstract(q = 'drosophila', fl=c('id','author'), limit = 5)
#' plosabstract(q = 'drosophila', fl='author', limit = 5)
#' plosabstract(q = 'drosophila', fl=c('id','author','title'), limit = 5)
#' plosabstract(q = 'drosophila', fl=c('id','author','title'), limit = 5, config=verbose())
#' }

plosabstract <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL, start = 0,
  limit = 10, sleep = 6, terms=NULL, fields=NULL, toquery=NULL, callopts=NULL, ...)
{
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- c("terms", "fields", "toquery", "callopts") %in% calls
  if(any(calls_vec))
    stop("The parameters terms, fields, toquery, and callopts replaced with q, fl, fq, ..., respectively")

  searchplos(q=paste('abstract:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             sleep=sleep, ...)
}
