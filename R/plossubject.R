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
#' 
#' # Highlighting
#' plossubject(q='marine ecology', fl='id,title', fq='doc_type:full', 
#'    limit = 2, highlighting=TRUE)
#' }
#' @export

plossubject <- function(q = NA, fl = 'id', fq = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(q=paste('subject:', '"', q, '"', sep=""), ...)
}