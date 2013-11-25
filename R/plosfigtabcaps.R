#' Search PLoS Journals figure and table captions.
#' 
#' @template plos
#' @return fields that you specify to return in a data.frame, along with the 
#' 		DOI's found.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', limit=100)
#' plosfigtabcaps(q='ecology', fl='figure_table_caption', limit=10)
#' 
#' # Highlighting
#' plosfigtabcaps(q='ecology', fl='figure_table_caption', limit = 2, highlighting=TRUE)
#' }
#' @export

plosfigtabcaps <- function(q = NA, fl = 'id', fq = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, sleep = 6, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  curl = getCurlHandle(), callopts=list())
{
  searchplos(q=paste('figure_table_caption:', '"', q, '"', sep=""), fl=fl, 
             fq=fq, sort=sort, highlighting=highlighting, start=start, 
             limit=limit, returndf=returndf, sleep=sleep, curl=curl, key=key, 
             callopts=callopts)
}