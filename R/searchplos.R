# Base function to search PLoS Journals

searchplos <- 
# Args:
#   terms: search terms (character)
#   fields: fields to return from search (character) [e.g., 'id,title'], 
#     any combination of search fields [see plosfields$field] 
#   limit: number of results to return (integer)
# Examples:
#   searchplos('drosophila', 'title', 5)

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
  if(!is.na(limit))
    args$rows <- limit
  args$wt <- "json"
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
}