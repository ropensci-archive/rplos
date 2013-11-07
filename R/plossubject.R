#' Search PLoS Journals subjects.
#' 
#' @template plos
#' @return Subject content, in addition to any other fields requested in a 
#'    data.frame.
#' @details See \url{http://www.plosone.org/taxonomy} for subject areas.
#' @examples \dontrun{
#' plossubject('marine ecology', limit = 5)
#' plossubject(terms='marine ecology',  fields = 'id,journal,title', limit = 20)
#' plossubject(terms='marine ecology', fields = 'id,journal', 
#'    toquery='doc_type:full', limit = 9)
#' plossubject(terms='marine ecology', fields = 'id,journal', 
#'    toquery=list('doc_type:full','!article_type_facet:"Issue%20Image"'), 
#'    limit = 9)
#' 
#' # Highlighting
#' plossubject(terms='marine ecology', fields='id,journal', limit = 2, highlighting=TRUE)
#' }
#' @export

plossubject <- function(terms = NA, fields = 'id', toquery = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(terms=paste('subject:', '"', terms, '"', sep=""), fields=fields, 
             toquery=toquery, sort=sort, highlighting=highlighting, start=start, 
             limit=limit, returndf=returndf, sleep=sleep, curl=curl, key=key, 
             callopts=callopts)
}