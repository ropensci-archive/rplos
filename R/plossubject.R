#' Search PLoS Journals subjects.
#'
#' @export
#' @template plos
#' @return Subject content, in addition to any other fields requested in a
#'    data.frame.
#' @details See \url{https://journals.plos.org/plosone/browse} for subject areas.
#' @examples \dontrun{
#' plossubject('marine ecology', limit = 5)
#' plossubject(q='marine ecology',  fl = c('id','journal','title'), limit = 20)
#' plossubject(q='marine ecology', fl = c('id','journal'),
#'    fq='doc_type:full', limit = 9)
#' plossubject(q='marine ecology', fl = c('id','journal'),
#'    fq=list('doc_type:full','!article_type_facet:"Issue%20Image"'),
#'    limit = 9)
#' }

plossubject <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL,
  start = 0, limit = 10, sleep = 6, errors = "simple", proxy = NULL,
  callopts=NULL, progress = NULL, ...) {

  searchplos(q=paste('subject:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             sleep=sleep, errors = errors,
             proxy = proxy, callopts = callopts, progress = progress, ...)
}
