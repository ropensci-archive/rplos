#' Base function to search PLoS Journals
#' 
#' @import data.table
#' @importFrom plyr ldply
#' @importFrom stringr str_extract
#' @importFrom lubridate now
#' @importFrom RJSONIO fromJSON
#' @template plos
#' @return An object of class "plos", with a list of length two, each element being 
#' a list itself.
#' @examples \dontrun{
#' searchplos(q='ecology', fl='id,publication_date', limit = 2)
#' searchplos('ecology', 'id,publication_date', limit = 2)
#' searchplos('ecology', 'id,title', limit = 2)
#' 
#' # Get only full article DOIs
#' out <- searchplos(q="*:*", fl='id', fq='doc_type:full', start=0, limit=250)
#' head(out)
#' 
#' # Get DOIs for only PLoS One articles
#' out <- searchplos(q="*:*", fl='id', fq='cross_published_journal_key:PLoSONE', start=0, limit=15)
#' head(out)
#' 
#' # Get DOIs for full article in PLoS One
#' out <- searchplos(q="*:*", fl='id', fq=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), limit=50)
#' head(out)
#' 
#' # Serch for many q
#' q <- c('ecology','evolution','science')
#' lapply(q, function(x) searchplos(x, limit=2))
#' 
#' # Query to get some PLOS article-level metrics, notice difference between two outputs
#' out <- searchplos(q="*:*", fl='id,counter_total_all,alm_twitterCount', fq='doc_type:full')
#' out_sorted <- searchplos(q="*:*", fl='id,counter_total_all,alm_twitterCount', fq='doc_type:full', sort='counter_total_all desc')
#' head(out)
#' head(out_sorted)
#' 
#' # A list of articles about social networks that are popular on a social network
#' searchplos(q="*:*", fl='id,alm_twitterCount', 
#'    fq=list('doc_type:full','subject:"Social networks"',
#'                 'alm_twitterCount:[100 TO 10000]'), 
#'    sort='counter_total_month desc')
#'                  
#' # Show me all articles that have these two words less then about 15 words apart.
#' searchplos(q='everything:"sports alcohol"~15', fl='title', fq='doc_type:full')
#' 
#' # Now let's try to narrow our results to 7 words apart. Here I'm changing the ~15 to ~7
#' searchplos(q='everything:"sports alcohol"~7', fl='title', fq='doc_type:full')
#' 
#' # Now, lets also only look at articles that have seen some activity on twitter. 
#' # Add "fq=alm_twitterCount:[1 TO *]" as a parameter within the fq argument.
#' searchplos(q='everything:"sports alcohol"~7', fl='alm_twitterCount,title', 
#'    fq=list('doc_type:full','alm_twitterCount:[1 TO *]'))
#' searchplos(q='everything:"sports alcohol"~7', fl='alm_twitterCount,title', 
#'    fq=list('doc_type:full','alm_twitterCount:[1 TO *]'), 
#'    sort='counter_total_month desc')
#'    
#' # Return partial doc parts
#' ## Return Abstracts only
#' out <- searchplos(q='*:*', fl='doc_partial_body,doc_partial_parent_id', 
#'    fq=list('doc_type:partial', 'doc_partial_type:Abstract'), limit=3)
#' ## Return Title's only
#' out <- searchplos(q='*:*', fl='doc_partial_body,doc_partial_parent_id', 
#'    fq=list('doc_type:partial', 'doc_partial_type:Title'), limit=3)
#' }
#' @export

searchplos <- function(q = NA, fl = 'id', fq = NA, sort = NA, start = 0, limit = NA, 
  key = NULL, sleep = 6, callopts=list(), terms, fields, toquery)
{
  calls <- deparse(sys.calls())
  calls_vec <- sapply(c("terms", "fields", "toquery"), function(x) grepl(x, calls))
  if(any(calls_vec))
    stop("The parameters terms, fields, and toquery have been replaced with q, fl, and fq, respectively")
  
  # Key
  if(is.null(key)) 
    key <- getOption("PlosApiKey", stop("need an API key for PLoS Journals"))
  
  # Function to trim leading and trailing whitespace, including newlines
  trim <- function (x) gsub("\\n\\s+", " ", gsub("^\\s+|\\s+$", "", x))
  
  # Enforce rate limits
  if(!Sys.getenv('plostime') == ""){
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if(timesince < 6){
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }
  
	url = 'http://api.plos.org/search'
  
#   # If highlighting=TRUE, then force id to be retuned so results can be matched easily
#   if(highlighting){  
#     if(!grepl("id", fl))
#       fl <- paste(fl, 'id', sep=",")
#   }
  
	if(is.na(limit)){limit <- 999} else{limit <- limit}
  args <- list()
  if(!is.na(fq[[1]])) {
    if(length(fq)==1) {
      args$fq <- fq
    } else
    {
      args <- fq
      names(args) <- rep("fq",length(args))
    } 
  } else
  { NULL }
  args$api_key <- key
  if(!is.na(q))
    args$q <- q
	if(!any(is.na(fl)))
    args$fl <- paste(fl, collapse=",")
  if(!is.na(start))
    args$start <- start
  if(!is.na(limit))
    args$rows <- limit
  if(!is.na(sort))
    args$sort <- sort
#   if(!is.na(highlighting))
#     args$hl <- tolower(highlighting)
  args$wt <- "json"
  
	argsgetnum <- list(q=q, rows=0, wt="json", api_key=key)
	getnum <- content(GET(url, query = argsgetnum))
	getnumrecords <- getnum$response$numFound
	if(getnumrecords > limit){getnumrecords <- limit} else{getnumrecords <- getnumrecords}
	
	if(min(getnumrecords, limit) < 1000) {
	  if(!is.na(limit))
	    args$rows <- limit
	  tt <- GET(url, query=args, callopts)
    stop_for_status(tt)
	  jsonout <- content(tt)
	  tempresults <- jsonout$response$docs
	  tempresults <- lapply(tempresults, function(x) lapply(x, trim))
    
	  # remove any empty lists
	  tempresults <- tempresults[!sapply(tempresults, length) == 0]
    
    # combine results if more than length=1
	  lengths <- sapply(tempresults, function(x) lapply(x, length))
    if(any(unlist(lengths) > 1)){
      foo <- function(x){
        if(length(x) > 1){ paste(x, collapse="; ") } else { x }
      }      
      tempresults <- lapply(tempresults, function(x) lapply(x, foo))
    }
    
# 	  if(highlighting){
# 	    res <- list(data=tempresults, highlighting=jsonout$highlighting)
# 	  } else
# 	  {
# 	    res <- list(data=tempresults, highlighting=NULL)
# 	  }
    res <- tempresults
    
	  resdf  <- plos2df(res)
#     class(resdf) <- "plos"
    return( resdf )
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
      
	    # remove any empty lists
	    tempresults <- tempresults[!sapply(tempresults, length) == 0]
	    
	    # combine results if more than length=1
	    lengths <- sapply(tempresults, function(x) lapply(x, length))
	    if(any(unlist(lengths) > 1)){
	      foo <- function(x){
	        if(length(x) > 1){ paste(x, collapse="; ") } else { x }
	      }      
	      tempresults <- lapply(tempresults, function(x) lapply(x, foo))
	    }
      
# 	    hlres <- jsonout$highlighting
# 	    out[[i]] <- list(dat=tempresults, hl=hlres)
      out[[i]] <- tempresults
	  }
	  
#     if(highlighting){
#       res <- list(data=lapply(out, "[[", "dat"), highlighting=lapply(out, "[[", "hl"))
# 	  } else
# 	  {
# 	    res <- list(data=tempresults, highlighting=NULL)
# 	  }
	  resdf  <- plos2df(out, TRUE)
# 	  class(resdf) <- "plos"
	  return( resdf )
	}
  Sys.setenv(plostime = as.numeric(now()))
}

plos2df <- function(input, many=FALSE)
#   plos2df <- function(input, many=FALSE)
{  
  if(many){
    input <- do.call(c, input)
#     input$highlighting <- do.call(c, input$highlighting)
  }
  
  if(is.null(input)){
    datout <- NULL
  } else{  
    maxlendat <- max(sapply(input, length))
    namesdat <- names(input[which.max(sapply(input, length))][[1]])
    dat <- lapply(input, function(x){
      if(!length(x) < maxlendat){ x } else {
        fillnames <- namesdat[!namesdat %in% names(x)]
        tmp <- c(rep(NA, length(fillnames)), x)
        names(tmp)[seq_along(fillnames)] <- fillnames
        tmp
      }
    })
    datout <- data.frame(rbindlist(dat))
  }
  return( datout ) 
}
#   if(is.null(input$highlighting)){
#     hlout <- NULL
#   } else {  
#     maxlenhl <- max(sapply(input$highlighting, length))
#     nameshl <- names(input$highlighting[which.max(sapply(input$highlighting, length))][[1]])  
#     hl <- lapply(input$highlighting, function(x){
#       if(!length(x) < maxlenhl){ x } else {
#         fillnames <- nameshl[!nameshl %in% names(x)]
#         tmp <- c(rep(NA, length(fillnames)), x)
#         names(tmp)[seq_along(fillnames)] <- fillnames
#         tmp
#       }
#     })
#     hlout <- data.frame(rbindlist(parsehighlight2(hl)))
#   }
#   
#   list(data = datout, highlighting = hlout)
# }