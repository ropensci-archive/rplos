#' Search PLoS Journals figure and table captions.
#' 
#' @template plos
#' @return fields that you specify to return in a data.frame, along with the 
#' 		DOI's found.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', limit=100)
#' plosfigtabcaps(q='ecology', fl='figure_table_caption', limit=10)
#' }
#' @export

plosfigtabcaps <- function(q = NA, fl = 'id', fq = NA, sort = NA,
  start = 0, limit = NA, key = NULL, 
  sleep = 6, callopts=list(), terms, fields, toquery)
{
  calls <- deparse(sys.calls())
  calls_vec <- sapply(c("terms", "fields", "toquery"), function(x) grepl(x, calls))
  if(any(calls_vec))
    stop("The parameters terms, fields, and toquery have been replaced with q, fl, and fq, respectively")
  
  searchplos(q=paste('figure_table_caption:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit,
             key=key, sleep=sleep, callopts=callopts)
}