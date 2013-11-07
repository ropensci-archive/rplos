#' Base function to search PLoS Journals
#' 
#' @import RCurl
#' @importFrom plyr ldply
#' @importFrom stringr str_extract
#' @importFrom lubridate now
#' @importFrom RJSONIO fromJSON
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
#' 
#' # Query to get some PLOS article-level metrics, notice difference between two outputs
#' out <- searchplos(terms="*:*", fields='id,counter_total_all,alm_twitterCount', 
#'    toquery='doc_type:full')
#' out_sorted <- searchplos(terms="*:*", fields='id,counter_total_all,alm_twitterCount', 
#'    toquery='doc_type:full', sort='counter_total_all desc')
#' head(out)
#' head(out_sorted) 
#' 
#' # A list of articles about social networks that are popular on a social network
#' searchplos(terms="*:*", fields='id,alm_twitterCount', 
#'    toquery=list('doc_type:full','subject:"Social networks"',
#'                 'alm_twitterCount:[100 TO 10000]'), 
#'    sort='counter_total_month desc')
#'                  
#' # Show me all articles that have these two words less then about 15 words apart.
#' searchplos(terms='everything:"sports alcohol"~15', fields='title', toquery='doc_type:full')
#' 
#' # Now let's try to narrow our results to 7 words apart. Here I'm changing the ~15 to ~7
#' searchplos(terms='everything:"sports alcohol"~7', fields='title', toquery='doc_type:full')
#' 
#' # Now, lets also only look at articles that have seen some activity on twitter. 
#' # Add “fq=alm_twitterCount:[1 TO *]” as a parameter within the toquery argument.
#' searchplos(terms='everything:"sports alcohol"~7', fields='alm_twitterCount,title', 
#'    toquery=list('doc_type:full','alm_twitterCount:[1 TO *]'))
#' searchplos(terms='everything:"sports alcohol"~7', fields='alm_twitterCount,title', 
#'    toquery=list('doc_type:full','alm_twitterCount:[1 TO *]'), 
#'    sort='counter_total_month desc')
#' 
#' # Highlighting!! What is that? Setting highlighting=TRUE gives you back the usual 
#' # fields you want, plus a separate data.frame of the places where the search terms
#' # were found
#' searchplos(terms='everything:"sports alcohol"~7', fields='alm_twitterCount,title', 
#'    toquery=list('doc_type:full','alm_twitterCount:[1 TO *]'), highlighting=TRUE)
#' 
#' # Highlighting with lots of results
#' out <- searchplos(terms='everything:"experiment"', fields='id,title', 
#'    toquery='doc_type:full', limit=1100, highlighting = TRUE)
#' lapply(out, head)
#' }
#' @export

searchplos <- function(terms = NA, fields = 'id', toquery = NA, sort = NA, 
  highlighting = FALSE, start = 0, limit = NA, returndf = TRUE, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  sleep = 6, curl = getCurlHandle(), callopts=list())
{
  # Function to trim leading and trailing whitespace, including newlines
  trim <- function (x) gsub("\\n\\s+", " ", gsub("^\\s+|\\s+$", "", x))
  
  # Function to get rid of html code stuff in highlighting outputs
  parsehighlight <- function(x) if(length(x) == 0){ NA } else { gsub("<[^>]+>","",x[[1]]) }
#   parsehighlight <- function(x) gsub("<[^>]+>","",x)
  
  # Enforce rate limits
  if(!Sys.getenv('plostime') == ""){
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if(timesince < 6){
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }
  
	url = 'http://api.plos.org/search'
  
  # If highlighting=TRUE, then force id to be retuned so results can be matched easily
  if(highlighting){  
    if(!grepl("id", fields))
      fields <- paste(fields, 'id', sep=",")
  }
  
	if(is.na(limit)){limit <- 999} else{limit <- limit}
  args <- list()
  if(!is.na(toquery[[1]])) {
    if(length(toquery)==1) {
      args$fq <- toquery
    } else
    {
      args <- toquery
      names(args) <- rep("fq",length(args))
    } 
  } else
  { NULL }
  args$api_key <- key
  if(!is.na(terms))
    args$q <- terms
	if(!any(is.na(fields)))
    args$fl <- paste(fields, collapse=",")
  if(!is.na(start))
    args$start <- start
  if(!is.na(limit))
    args$rows <- limit
  if(!is.na(sort))
    args$sort <- sort
  if(!is.na(highlighting))
    args$hl <- tolower(highlighting)
  args$wt <- "json"
  
	argsgetnum <- list(q=terms, rows=0, wt="json", api_key=key)
	getnum <- getForm(url, .params = argsgetnum, curl = curl, .encoding=)
	getnumrecords <- fromJSON(I(getnum))$response$numFound
	if(getnumrecords > limit){getnumrecords <- limit} else{getnumrecords <- getnumrecords}
	
	if(min(getnumrecords, limit) < 1000) {
	  if(!is.na(limit))
	    args$rows <- limit
	  tt <- getForm(url, .params = args, .opts=callopts, curl = curl)
	  jsonout <- fromJSON(I(tt))
	  tempresults <- jsonout$response$docs
	  tempresults <- lapply(tempresults, function(x) lapply(x, trim))
    
    # replace any empty lists with some data
	  tempresults <- tempresults[!sapply(tempresults, length) == 0]
    
    # combine results if more than length=1
	  lengths <- sapply(tempresults, function(x) lapply(x, length))
    if(any(lengths > 1)){
      foo <- function(x){
        if(length(x) > 1){ paste(x, collapse="; ") } else { x }
      }      
      tempresults <- lapply(tempresults, function(x) lapply(x, foo))
    }
    
	  if(returndf){
      dat <- do.call(rbind, lapply(tempresults, function(x) data.frame(x, stringsAsFactors=FALSE)))
      hldt <- ldply(lapply(jsonout$highlighting, parsehighlight))
      if(highlighting){
        return( list(data=dat, highlighting=hldt) )
      } else
      {
        return( dat )
      }
	  } else
	    { 
        if(highlighting){
          return( list(data=tempresults, highlighting=jsonout$highlighting) )
        } else
        {
          return( tempresults )
        }
	    }
	} else
	{ 
	  byby <- 500
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
	    tt <- GET(url, query=args, callopts)
      stop_for_status(tt)
	    jsonout <- content(tt)
	    tempresults <- jsonout$response$docs
	    tempresults <- lapply(tempresults, function(x) lapply(x, trim))
      
	    # replace any empty lists with some data
	    tempresults <- tempresults[!sapply(tempresults, length) == 0]
	    
	    # combine results if more than length=1
	    lengths <- sapply(tempresults, function(x) lapply(x, length))
	    if(any(lengths > 1)){
	      foo <- function(x){
	        if(length(x) > 1){ paste(x, collapse="; ") } else { x }
	      }      
	      tempresults <- lapply(tempresults, function(x) lapply(x, foo))
	    }
      
	    hlres <- jsonout$highlighting
	    out[[i]] <- list(dat=tempresults, hl=hlres)
	  }
	  if(returndf){
	    dat <- do.call(rbind.data.frame, lapply(lapply(out, "[[", "dat"), function(x) do.call(rbind, lapply(x, function(x) data.frame(x, stringsAsFactors=FALSE)) ) ))
	    hldt <- do.call(rbind, lapply(lapply(out, "[[", "hl"), function(x) ldply(lapply(x, parsehighlight)) ))
	    if(highlighting){
	      return( list(data=dat, highlighting=hldt) )
	    } else
	    {
	      return( dat )
	    }
	  } else
	  {
	    if(highlighting){
	      return( list(data=lapply(out, "[[", "dat"), highlighting=lapply(out, "[[", "hl")) )
	    } else
	    {
	      return( tempresults )
	    }
	  }
	}
  Sys.setenv(plostime = as.numeric(now()))
}