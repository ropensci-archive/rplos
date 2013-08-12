#' Search PLoS Journals abstracts.
#' 
#' @template plos
#' @return Abstract content, in addition to any other fields requested in a list.
#' @examples \dontrun{
#' plosabstract(terms = 'drosophila', fields='abstract', limit=10)
#' plosabstract(terms = 'drosophila', fields='id,author', limit = 5)
#' plosabstract(terms = 'drosophila', fields='id,author,title', limit = 5)
#' }
#' @export

plosabstract <- function(terms = NA, fields = 'id', toquery = NA, start = 0, 
                        limit = NA, returndf = TRUE, sleep = 6, ..., curl = getCurlHandle(),
                        key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
{
  searchplos(terms=paste('abstract:', '"', terms, '"', sep=""), fields = fields, 
             toquery = toquery, start = start, limit = limit, 
             returndf = returndf, sleep = 6, ..., curl = getCurlHandle(),
             key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}