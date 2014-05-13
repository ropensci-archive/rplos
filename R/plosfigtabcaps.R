#' Search PLoS Journals figure and table captions.
#' 
#' @export
#' @template plos
#' @return fields that you specify to return in a data.frame, along with the 
#' 		DOI's found.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', limit=100)
#' plosfigtabcaps(q='ecology', fl='figure_table_caption', limit=10)
#' }

plosfigtabcaps <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL,
  start = 0, limit = 10, key = NULL, 
  sleep = 6, callopts=list(), terms=NULL, fields=NULL, toquery=NULL)
{
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- c("terms", "fields", "toquery") %in% calls
  if(any(calls_vec))
    stop("The parameters terms, fields, and toquery have been replaced with q, fl, and fq, respectively")
  
  searchplos(q=paste('figure_table_caption:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             key=key, sleep=sleep, callopts=callopts)
}