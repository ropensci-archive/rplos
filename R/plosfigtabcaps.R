#' Search PLoS Journals figure and table captions.
#' @param terms search terms
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param numrecords: print number of results only 'TRUE' or 'FALSE' (character)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results, and fields that you specify to return.
#' @examples \dontrun{
#'   plosfigtabcaps('ecology', 'id', 500)
#'   plosfigtabcaps('ecology', 'figure_table_caption', 10)
#'   plosfigtabcaps('is', 'id', 2000)
#'   plosfigtabcaps('ecology', 'id', 10, numrecords = 'FALSE')
#' }
#' @export
plosfigtabcaps <- 

function(terms, fields = NA, limit = NA, numrecords = FALSE,
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
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

  if(numrecords == 'TRUE') {getnumrecords} else
  {
  if(min(getnumrecords, limit) < 1000) {
    if(!is.na(limit))
      args$rows <- limit
    tt <- getForm(url, 
      .params = args,
      ...,
      curl = curl)
    jsonout <- fromJSON(I(tt))
    tempresults <- jsonout$response$docs
    numres <- length(tempresults) # number of search results 
    names(numres) <- 'Number of search results'
    dfresults <- data.frame( do.call(rbind, tempresults) )
    return(list(numres, dfresults))  
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
      dfresults__ <- do.call(rbind, dfresults_)
      names(getnumrecords) <- 'Number of search results'
      return(list(getnumrecords, dfresults__))
    }
  }
}