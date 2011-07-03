# Function to search PLoS Journals figure and table captions

plosfigtabcaps <- 
# Args:
#   terms: search terms (character)
#   fields: fields to return from search (character) [e.g., 'id,title'], 
#     any combination of search fields [see plosfields$field] 
#   limit: number of results to return (integer)
# Examples:
#   plosfigtabcaps('ecology', 'id', 2)

function(terms, fields = NA, limit = NA, 
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
{
  args <- list(apikey = key)
  if(!is.na(terms))
    args$q <- terms
  if(!is.na(fields))
    args$fl <- fields
  args$wt <- "json"
  
  argsgetnum <- args
  argsgetnum$rows <- 0
  getnum <- getForm(url, 
    .params = argsgetnum,
#     ...,
    curl = curl)
  getnumrecords <- fromJSON(I(getnum))$response$numFound
  
  if(min(getnumrecords, limit) < 1000) {
    if(!is.na(limit))
      args$rows <- limit
    tt <- getForm(url, 
      .params = args,
#     ...,
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
#         ...,
          curl = curl)
        jsonout <- fromJSON(I(tt))
        tempresults <- jsonout$response$docs  
        dfresults_[[i]] <- data.frame( do.call(rbind, tempresults) )
      }
      dfresults__ <- do.call(rbind, dfresults_)
      return(list(getnumrecords, dfresults__))
    }
}