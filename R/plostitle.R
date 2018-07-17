#' Search PLoS Journals titles.
#'
#' @export
#' @template plos
#' @return Titles, in addition to any other fields requested in a data.frame.
#' @examples \dontrun{
#' plostitle(q='drosophila', fl='title', limit=99)
#' plostitle(q='drosophila', fl=c('title','journal'), limit=10)
#' plostitle(q='drosophila',  limit = 5)
#' }

plostitle <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL,
  start = 0, limit = 10, sleep = 6, errors = "simple", proxy = NULL,
  callopts=NULL, progress = NULL, ...) {

  searchplos(q=paste('title:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             sleep=sleep, errors = errors,
             proxy = proxy, callopts = callopts, progress = progress, ...)
}
