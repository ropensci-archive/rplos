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
  start = 0, limit = 10, sleep = 6, errors = "simple", proxy = NULL,
  callopts=NULL, ...) {

  searchplos(q=paste('figure_table_caption:', '"', q, '"', sep=""), fl=fl, fq=fq,
             sort=sort, start=start, limit=limit, sleep=sleep, errors = errors,
             proxy = proxy, callopts = callopts, ...)
}
