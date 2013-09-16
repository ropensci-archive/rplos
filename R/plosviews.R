#' Search PLoS Journals by article views.
#' 
#' @import RJSONIO RCurl 
#' @importFrom stringr str_split
#' @param search search terms (character)
#' @param byfield field to search by, e.g., subject, author, etc. (character)
#' @param views views all time (alltime) or views last 30 days (last30) 
#'    (character)
#' @param limit number of results to return (integer)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (results = FALSE), or number of search
#'    results plus the results themselves (results = TRUE).
#' @examples \dontrun{
#' plosviews('10.1371/journal.pone.0002154', 'id', 'alltime')
#' plosviews('10.1371/journal.pone.0002154', 'id', 'last30')
#' plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30')
#' plosviews(search='marine ecology', byfield='subject', views='alltime', 
#'    limit=5)
#' plosviews('evolution', views = 'alltime', limit = 99)
#' plosviews('bird', views = 'alltime', limit = 99)
#' }
#' @export
plosviews <- function(search, byfield = NA, views = 'alltime', limit = NA,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., curl = getCurlHandle() )
{
	url = 'http://api.plos.org/search'
	
  args <- list(apikey = key)
  if(is.na(byfield)) {byfield_ <- NULL} else
    {byfield_ <- paste(byfield, ":", sep="")}
  if(!is.na(search))
    args$q <- paste(byfield_, '"', search, '"', sep="")
  if(!is.na(views))
    if (views == 'alltime') {args$fl <- 'id,counter_total_all'} else
      if (views == 'last30') {args$fl <- 'id,counter_total_month'} else
        {args$fl <- 'id,counter_total_all,counter_total_month'}
  if(!is.na(limit))
    args$rows <- limit
  args$wt <- "json"
  tt <- getForm(url,
    .params = args,
    ...,
    curl = curl)
  jsonout <- fromJSON(I(tt))
  temp <- jsonout$response$docs
  df <- do.call(rbind, lapply(temp, function(x) data.frame(x)))
  newcol <- do.call(rbind, lapply(str_split(df$id, "/"), function(x) x[length(x) < 3]))
  newcol_ <- paste(newcol[,1], newcol[,2], sep="/")
  newdf <- merge(data.frame(newcol_), df, by.x="newcol_", by.y="id")
  newdf[order(newdf[,2]), ]
}