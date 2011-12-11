#' Search PLoS Journals subjects.
#' @param terms search terms for article subjects (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [see plosfields$field]
#' @param limit number of results to return (integer)
#' @param results print results or not (TRUE or FALSE)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (results = FALSE), or number of search 
#'    results plus the results themselves (results = TRUE).
#' @export
#' @examples
#' plossubject('ecology', 'subject', 999, 'FALSE')
#' plossubject('ecology', 'subject', 9, 'FALSE')
#' plossubject('ecology',  limit = 5, results = 'TRUE')
#' plossubject('ecology',  'subject', limit = 99, results = 'TRUE')
plossubject <- 

function(terms, fields = NA, limit = NA, results = FALSE, 
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
{
  args <- list(apikey = key)
  if(!is.na(terms))
    args$q <- paste('subject:', terms, sep="")
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
  if (results == "TRUE") { return(list(numres, dfresults)) }
    else { return(numres) }
}