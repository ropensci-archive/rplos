#' Search results on a keyword over all fields in PLoS Journals.
#' 
#' @import RJSONIO RCurl ggplot2
#' @importFrom plyr ldply 
#' @param terms search terms (character)
#' @param vis visualize results in bar plot or not (TRUE or FALSE)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param callopts Optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (vis = FALSE), or number of search in a table
#'    and a histogram of results (vis = TRUE).
#' @examples \dontrun{
#' plosword('Helianthus')
#' plosword(list('monkey','Helianthus','sunflower','protein','whale'), 
#'    vis = 'TRUE')
#' out <- plosword(list('monkey','replication','design','sunflower','whale'), 
#'    vis = 'TRUE')
#' out[[1]] # results in a data frame 
#' out[[2]] # results in a bar plot
#' 
#' # Pass in curl options
#' plosword('Helianthus', callopts=list(verbose=TRUE))
#' }
#' @export
plosword <- function(terms, vis = FALSE,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  curl = getCurlHandle(), callopts=list()) 
{
  Term = NULL
  No_Articles = NULL
	url = 'http://api.plos.org/search'
	
  if (length(terms) == 1) {
  args <- list(apikey = key)
  if(!is.na(terms))
    args$q <- terms
  args$fl <- "id" # just ID field to speed up return of search results
  args$wt <- "json"
  tt <- getForm(url, 
    .params = args,
    .opts=callopts,
    curl = curl)
  numres <- fromJSON(I(tt))$response$numFound
  names(numres) <- 'Number of articles with search term'
  return(numres)
  }  
  else {
    search_ <- function(x) {
        args <- list(apikey = key)
        if(!is.na(x))
        args$q <- x
        args$fl <- "id" # just ID field to speed up return of search results
        args$wt <- "json"
        tt <- getForm(url, 
          .params = args,
          .opts=callopts,
          curl = curl)
        numres <- fromJSON(I(tt))$response$numFound
        return(numres)
    }
    temp <- ldply(terms, search_)
    names(temp) <- "No_Articles"
    temp$Term <- terms
    temp$Term <- as.character(temp$Term)
      if (vis == "TRUE") {
     ##   if(!require(ggplot2)) stop("must first install 'ggplot2' package.")
        p <- ggplot(temp, aes(x=Term, y=No_Articles)) + geom_bar(stat="identity")
      }
    return(list(table = temp, plot = p))
  }
}
