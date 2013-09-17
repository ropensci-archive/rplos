#' Search PLoS Journals figure and table captions.
#' 
#' @template plos
#' @return Fields that you specify to return in a data.frame, along with the 
#' 		DOI's found.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', 100)
#' plosfigtabcaps(terms='ecology', fields='figure_table_caption', limit=10)
#' }
#' @export

plosfigtabcaps <- function(terms = NA, fields = 'id', toquery = NA, start = 0, 
  limit = NA, returndf = TRUE, sleep = 6, curl = getCurlHandle(),
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  callopts=list())
{
  searchplos(terms=paste('figure_table_caption:', '"', terms, '"', sep=""), fields=fields, 
             toquery=toquery, start=start, limit=limit, returndf=returndf, 
             sleep=sleep, curl=curl, key=key, callopts=callopts)
}