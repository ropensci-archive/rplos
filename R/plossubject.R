#' Search PLoS Journals subjects.
#'
#' @export
#' @template plos
#' @return Subject content, in addition to any other fields requested in a
#'    data.frame.
#' @details See \url{http://www.plosone.org/taxonomy} for subject areas.
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
  start = 0, limit = 10,
  sleep = 6, terms=NULL, fields=NULL, toquery=NULL, callopts=NULL, ...)
{
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- c("terms", "fields", "toquery", "callopts") %in% calls
  if(any(calls_vec))
    stop("The parameters terms, fields, toquery, and callopts replaced with q, fl, fq, ..., respectively")

  searchplos(q=paste('subject:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             sleep=sleep, ...)
}
