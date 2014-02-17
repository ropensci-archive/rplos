#' Search PLoS Journals subjects.
#' 
#' @template plos
#' @return Subject content, in addition to any other fields requested in a 
#'    data.frame.
#' @details See \url{http://www.plosone.org/taxonomy} for subject areas.
#' @examples \dontrun{
#' plossubject('marine ecology', limit = 5)
#' plossubject(q='marine ecology',  fl = 'id,journal,title', limit = 20)
#' plossubject(q='marine ecology', fl = 'id,journal', 
#'    fq='doc_type:full', limit = 9)
#' plossubject(q='marine ecology', fl = 'id,journal', 
#'    fq=list('doc_type:full','!article_type_facet:"Issue%20Image"'), 
#'    limit = 9)
#' }
#' @export

plossubject <- function(q = NA, fl = 'id', fq = NA, sort = NA,
  start = 0, limit = NA, key = NULL, 
  sleep = 6, callopts=list(), terms, fields, toquery)
{
  calls <- deparse(sys.calls())
  calls_vec <- sapply(c("terms", "fields", "toquery"), function(x) grepl(x, calls))
  if(any(calls_vec))
    stop("The parameters terms, fields, and toquery have been replaced with q, fl, and fq, respectively")
  
  searchplos(q=paste('subject:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             key=key, sleep=sleep, callopts=callopts)
}