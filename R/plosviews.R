# Function to search PLoS Journals, by article views

plosviews <- 
# Args:
#   search: search terms (character)
#   byfield: field to search by, e.g., subject, author, etc. (character)
#   views: views all time (alltime) or views last 30 days (last30) (character)
#   limit: number of results to return (integer)
# Examples:
#   plosviews('10.1371/journal.pone.0002154', 'id', 'alltime')
#   plosviews('10.1371/journal.pone.0002154', 'id', 'last30')
#   plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30')
#   plosviews('ecology', 'subject', 'alltime', 99)
#   plosviews('evolution', views = 'alltime', limit = 99)
#   plosviews('bird', views = 'alltime', limit = 99)

function(search, byfield = NA, views = 'alltime', limit = NA,
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
{
  args <- list(apikey = key)
  if(is.na(byfield)) {byfield_ <- NULL} else
    {byfield_ <- paste(byfield, ":", sep="")}    
  if(!is.na(search))
    args$q <- paste(byfield_, search, sep="")
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
  newdf_ <- newdf[order(newdf[,2]), ]
  return(newdf_)
}