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
#' }
#' @export

plossubject <- function(terms = NA, fields = 'id', toquery = NA, start = 0, 
        limit = NA, returndf = TRUE, sleep = 6, ..., curl = getCurlHandle(),
        key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
{
  searchplos(terms=paste('subject:', '"', terms, '"', sep=""), fields = fields, 
             toquery = toquery, start = start, limit = limit, 
             returndf = returndf, sleep = 6, ..., curl = getCurlHandle(),
             key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}