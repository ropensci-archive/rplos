#' Search PLoS Journals authors.
#' 
#' @template plos
#' @return Author names, in addition to any other fields requested in a data.frame.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', 100)
#' plosfigtabcaps(terms='ecology', fields='figure_table_caption', limit=10)
#' }
#' @export

plosauthor <- function(terms = NA, fields = 'id', toquery = NA, start = 0, 
                           limit = NA, returndf = TRUE, sleep = 6, ..., curl = getCurlHandle(),
                           key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
{
  searchplos(terms=paste('author:', '"', terms, '"', sep=""), fields = fields, 
             toquery = toquery, start = start, limit = limit, 
             returndf = returndf, sleep = 6, ..., curl = getCurlHandle(),
             key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}