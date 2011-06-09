# Function to plot results through time for serach results from PLoS Journals

plot_throughtime <- 
# Args:
#   terms: search terms (character)
#   vis: visualize results in bar plot or not (TRUE or FALSE) 
# Examples:
#   plot_throughtime('Helianthus')

function(terms,
  url = 'http://api.plos.org/search',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
{
  if (length(terms) == 1) {
  args <- list(apikey = key)
  if(!is.na(terms))
    args$q <- terms
  args$fl <- "id" # just ID field to speed up return of search results
  args$wt <- "json"
  tt <- getForm(url, 
    .params = args,
    ...,
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
          ...,
          curl = curl)
        numres <- fromJSON(I(tt))$response$numFound
        return(numres)
    }
    temp <- ldply(terms, search_)
    names(temp) <- "No_Articles"
    temp$Term <- terms
    temp$Term <- as.character(temp$Term)
      if (vis == "TRUE") {
        if(!require(ggplot2)) stop("must first install 'ggplot2' package.")
        p <- ggplot(temp, aes(x=Term, y=No_Articles)) + geom_bar()
      }
    return(list(table = temp, plot = p))
  }
}