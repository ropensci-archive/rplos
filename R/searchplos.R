#' Base function to search PLoS Journals
#' 
#' @import RJSONIO RCurl
#' @importFrom plyr ldply
#' @importFrom stringr str_extract
#' @importFrom lubridate now
#' @template plos
#' @return Either a data.frame if returndf=TRUE, or a list if returndf=FALSE.
#' @examples \dontrun{
#' searchplos('ecology', 'id,publication_date', limit = 2)
#' searchplos('ecology', 'id,title', limit = 2)
#' 
#' # Get only full article DOIs
#' searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, 
#' limit=250)
#' 
#' # Get DOIs for only PLoS One articles
#' searchplos(terms="*:*", fields='id', 
#' toquery='cross_published_journal_key:PLoSONE', start=0, limit=15)
#' 
#' # Get DOIs for full article in PLoS One
#' searchplos(terms="*:*", fields='id', 
#'    toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), 
#'    start=0, limit=50)
#' 
#' # Serch for many terms
#' library(plyr)
#' terms <- c('ecology','evolution','science')
#' llply(terms, function(x) searchplos(x, limit=2))
#' }
#' @export

searchplos <- function(terms = NA, fields = 'id', toquery = NA, start = 0, 
  limit = NA, returndf = TRUE, key = getOption("PlosApiKey", 
  stop("need an API key for PLoS Journals")), sleep = 6, ..., 
  curl = getCurlHandle())
{
  # Function to trim leading and trailing whitespace, including newlines
  trim <- function (x) gsub("\\n\\s+", " ", gsub("^\\s+|\\s+$", "", x))
  
  # Enforce rate limits
  if(!Sys.getenv('plostime') == ""){
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if(timesince < 6){
#       assert_that(is.numeric(sleep))
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }
  
	url = 'http://api.plos.org/search'

	if(is.na(limit)){limit <- 999} else{limit <- limit}
  args <- list()
  if(!is.na(toquery[[1]])) {
    if(length(toquery)==1) {args$fq <- toquery} else
        {args <- list(fq=toquery[[1]], fq=toquery[[2]])} } else
          NULL
  args$api_key <- key
  if(!is.na(terms))
    args$q <- terms
	if(!any(is.na(fields)))
    args$fl <- paste(fields, collapse=",")
  if(!is.na(start))
    args$start <- start
  if(!is.na(limit))
    args$rows <- limit
  args$wt <- "json"
  
	argsgetnum <- list(q=terms, rows=0, wt="json", api_key=key)
	getnum <- getForm(url, .params = argsgetnum, curl = curl)
	getnumrecords <- fromJSON(I(getnum))$response$numFound
	if(getnumrecords > limit){getnumrecords <- limit} else{getnumrecords <- getnumrecords}
	
	if(min(getnumrecords, limit) < 1000) {
	  if(!is.na(limit))
	    args$rows <- limit
	  tt <- getForm(url, .params = args, ..., curl = curl)
	  jsonout <- fromJSON(I(tt))
	  tempresults <- jsonout$response$docs
# 	  tempresults <- llply(tempresults, insertnones)
    # clean up whitespace and newlines
# 	  tempresults <- lapply(tempresults, trim)
	  tempresults <- lapply(tempresults, function(x) lapply(x, trim))
	  if(returndf == TRUE){
# 	    tempresults_ <- ldply(tempresults, function(x) as.data.frame(x))
	    tempresults_ <- ldfast(tempresults, TRUE)
	  } else
	  {tempresults_ <- tempresults}
	  
	  return(tempresults_)
	  
	} else
	{ 
	  byby <- 1000
	  
	  getvecs <- seq(from=1, to=getnumrecords, by=byby)
	  lastnum <- as.numeric(str_extract(getnumrecords, "[0-9]{3}$"))
	  if(lastnum==0)
	    lastnum <- byby
	  if(lastnum > byby){
	    lastnum <- getnumrecords-getvecs[length(getvecs)]
	  } else 
	  {lastnum <- lastnum}
	  getrows <- c(rep(byby, length(getvecs)-1), lastnum)
	  out <- list()
	  message("Looping - printing iterations...")
	  for(i in 1:length(getvecs)) {
	    cat(i,"\n")
	    args$start <- getvecs[i]
	    args$rows <- getrows[i]
	    tt <- getForm(url, .params = args,...,curl = curl)
	    jsonout <- fromJSON(I(tt))
	    tempresults <- jsonout$response$docs 
# 	    tempresults <- llply(tempresults, insertnones)
	    # clean up whitespace and newlines
# 	    tempresults <- lapply(tempresults, trim)
	    tempresults <- lapply(tempresults, function(x) lapply(x, trim))
	    out[[i]] <- tempresults
	  }
	  if(returndf == TRUE){
	    tempresults_ <- do.call(rbind.data.frame, lapply(out, function(x) do.call(rbind, x)))
	  } else
	  {tempresults_ <- out}
	  return(tempresults_)
	}
  Sys.setenv(plostime = as.numeric(now()))
}