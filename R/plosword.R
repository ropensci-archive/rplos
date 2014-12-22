#' Search results on a keyword over all fields in PLoS Journals.
#'
#' @export
#' @import ggplot2
#' @importFrom plyr ldply
#' 
#' @param terms search terms (character)
#' @param vis visualize results in bar plot or not (TRUE or FALSE)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... Optional additional curl options (debugging tools mostly)
#' 
#' @return Number of search results (vis = FALSE), or number of search in a table
#'    and a histogram of results (vis = TRUE).
#' @examples \dontrun{
#' plosword('Helianthus')
#' out <- plosword(list('monkey','replication','design','sunflower','whale'),
#'    vis = TRUE)
#' out[[1]] # results in a data frame
#' out[[2]] # results in a bar plot
#'
#' # Pass in curl options
#' plosword('Helianthus', config=verbose())
#' }

plosword <- function(terms, vis = FALSE,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), ...)
{
  Term=No_Articles=NULL

  if (length(terms) == 1) {
    setNames(search_(terms, key, ...), 'Number of articles with search term')
  } else {
    temp <- setNames(ldply(terms, search_, key=key, ...), "No_Articles")
    temp$Term <- terms
    temp$Term <- as.character(temp$Term)
    if (vis) {
      p <- ggplot(temp, aes(x=Term, y=No_Articles)) +
        geom_bar(stat="identity") +
        theme_grey(base_size = 18)
      return(list(table = temp, plot = p))
    }
    return( temp )
  }
}

search_ <- function(terms, key, ...){
  args <- ploscompact(list(apikey = key, q = terms, fl="id", wt="json"))
  tt <- GET(pbase(), query = args, ...)
  stop_for_status(tt)
  jsonlite::fromJSON(content(tt, "text"), FALSE)$response$numFound
}
