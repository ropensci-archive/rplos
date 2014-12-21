#' Search PLoS Journals by article views.
#'
#' @import httr
#' @importFrom stringr str_split
#' @importFrom plyr compact
#' @param search search terms (character)
#' @param byfield field to search by, e.g., subject, author, etc. (character)
#' @param views views all time (alltime) or views last 30 days (last30)
#'    (character)
#' @param limit number of results to return (integer)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param callopts Optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @examples \dontrun{
#' plosviews('10.1371/journal.pone.0002154', 'id', 'alltime')
#' plosviews('10.1371/journal.pone.0002154', 'id', 'last30')
#' plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30')
#' plosviews(search='marine ecology', byfield='subject', limit=50)
#' plosviews(search='evolution', views = 'alltime', limit = 99)
#' plosviews('bird', views = 'alltime', limit = 99)
#' }
#' @export
plosviews <- function(search, byfield = NULL, views = 'alltime', limit = NULL,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  callopts=list(), curl = getCurlHandle())
{
	url = 'http://api.plos.org/search'

  args <- compact(list(apikey = key, wt = "json", fq = "doc_type:full", rows = limit))
  if(is.null(byfield)) {byfield_ <- byfield} else
    {byfield_ <- paste(byfield, ":", sep="")}
  if(!is.na(search))
    args$q <- paste(byfield_, '"', search, '"', sep="")
  if(!is.na(views))
    if (views == 'alltime') {args$fl <- 'id,counter_total_all'} else
      if (views == 'last30') {args$fl <- 'id,counter_total_month'} else
        {args$fl <- 'id,counter_total_all,counter_total_month'}
	tt <- GET(url, query=args, callopts)
	stop_for_status(tt)
	temp <- content(tt)$response$docs
  df <- do.call(rbind, lapply(temp, function(x) data.frame(x)))
	df[order(df[,2]), ]
}
