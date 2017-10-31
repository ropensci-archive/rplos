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
#' }
plosabstract <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL, start = 0,
  limit = 10, sleep = 6, errors = "simple", proxy = NULL, callopts = NULL, ...) {

  searchplos(q=paste('abstract:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit, sleep=sleep,
             errors = errors, proxy = proxy, callopts = callopts, ...)
}
