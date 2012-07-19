#' Base function to search PLoS Journals
#' @import RJSONIO RCurl
#' @param terms search terms (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [type 'data(plosfields)', then 
#'    'plosfields']
#' @param toquery list specific fields to query (if NA, all queried)
#' @param start record to start at (used in combination with limit when 
#' you need to cycle through more results than the max allowed=1000)
#' @param limit number of results to return (integer)
#' @param returndf Return data.frame of results or not (defaults to TRUE).
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (vis = FALSE), or number of search in a table
#'    and a histogram of results (vis = TRUE).
#' @export
#' @examples \dontrun{
#' searchplos(terms='ecology', fields='id', limit = 1200)
#' searchplos('ecology', 'id,publication_date', limit = 2)
#' searchplos('ecology', 'id,title', limit = 2)
#' searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
#' searchplos(terms="*:*", fields='id', toquery='cross_published_journal_key:PLoSONE', start=0, limit=250)
#' searchplos(terms="*:*", fields='id', 
#'    toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), 
#'    start=0, limit=250)
#' }
searchplos <- function(terms = NA, fields = NA, toquery = NA, start = 0, limit = NA, 
	returndf = TRUE,  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
{
	insertnones <- function(x) {
		toadd <- fields[! fields %in% names(x) ]
		values <- rep("none", length(toadd))
		names(values) <- toadd
		values <- as.list(values)
		x <- c(x, values)
		x
	}
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
	getnum <- getForm(url, 
		.params = argsgetnum,
		curl = curl)
	getnumrecords <- fromJSON(I(getnum))$response$numFound
	if(getnumrecords > limit){getnumrecords <- limit} else{getnumrecords <- getnumrecords}
	
  if(min(getnumrecords, limit) < 1000) {
    if(!is.na(limit))
      args$rows <- limit
    tt <- getForm(url, 
      .params = args,
      ...,
      curl = curl)
    jsonout <- fromJSON(I(tt))
    tempresults <- jsonout$response$docs
    tempresults <- llply(tempresults, insertnones)
    if(returndf == TRUE){
    	tempresults_ <- ldply(tempresults, function(x) as.data.frame(x))
    } else
    	{tempresults_ <- tempresults}
    tempresults_
  } else
    { 
    	getvecs <- seq(from=1, to=getnumrecords, by=500)
    	lastnum <- as.numeric(str_extract(getnumrecords, "[0-9]{3}$"))-1
    	if(lastnum > 500){
    		lastnum <- getnumrecords-getvecs[length(getvecs)]
    	} else 
    		{lastnum <- lastnum}
    	getrows <- c(rep(500, length(getvecs)-1), lastnum)
      out <- list()
    	for(i in 1:length(getvecs)) {
    		cat(i,"\n")
    		args$start <- getvecs[i]
    		args$rows <- getrows[i]
    		tt <- getForm(url, 
    			.params = args,
    			...,
    			curl = curl)
    		jsonout <- fromJSON(I(tt))
    		tempresults <- jsonout$response$docs 
    		tempresults <- llply(tempresults, insertnones)
    		out[[i]] <- tempresults
    	}
      if(returndf == TRUE){
      	tempresults_ <- ldply(out, function(x) ldply(x, function(y) as.data.frame(y)))
      } else
      	{tempresults_ <- out}
      tempresults_
    }
}