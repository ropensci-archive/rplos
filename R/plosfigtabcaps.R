#' Search PLoS Journals figure and table captions.
#' 
#' @import RJSONIO RCurl
#' @param terms search terms
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  	the returned value in here (avoids unnecessary footprint)
#' @return Fields that you specify to return in a data.frame, along with the 
#' 		DOI's found.
#' @examples \dontrun{
#' plosfigtabcaps('ecology', 'id', 500)
#' plosfigtabcaps('ecology', 'figure_table_caption', 10)
#' }
#' @export
plosfigtabcaps <- function(terms, fields = NA, limit = NA,
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., curl = getCurlHandle() ) 
{
  args <- list(apikey = key)
  if(!is.na(terms))
    args$q <- paste('figure_table_caption:', terms, sep="")
  if(!is.na(fields))
    args$fl <- fields
  args$wt <- "json"
  
  argsgetnum <- args
  argsgetnum$rows <- 0
  getnum <- getForm(url, 
    .params = argsgetnum,
    ...,
    curl = curl)
  getnumrecords <- fromJSON(I(getnum))$response$numFound

  if(min(getnumrecords, limit) < 1000) {
    if(!is.na(limit))
      args$rows <- limit
    tt <- getForm(url, 
      .params = args,
      ...,
      curl = curl)
    jsonout <- fromJSON(I(tt))
    tempresults <- jsonout$response$docs
    data.frame( do.call(rbind, tempresults) )
  } else
    { 
      gotothis <- min(getnumrecords, limit)
      getvecs <- seq(from=1, to=gotothis, by=500)
      args$rows <- 500
      dfresults_ <- list()
      for(i in 1:length(getvecs)) {
        args$start <- i
        tt <- getForm(url, 
          .params = args,
          ...,
          curl = curl)
        jsonout <- fromJSON(I(tt))
        tempresults <- jsonout$response$docs  
        dfresults_[[i]] <- data.frame( do.call(rbind, tempresults) )
      }
      do.call(rbind, dfresults_)
    }
}