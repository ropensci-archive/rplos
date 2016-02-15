#' Search results on a keyword over all fields in PLoS Journals.
#'
#' @export
#' @param terms search terms (character)
#' @param vis visualize results in bar plot or not (TRUE or FALSE)
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
#' library("httr")
#' plosword('Helianthus', config=verbose())
#' }

plosword <- function(terms, vis = FALSE, ...) {
  
  Term <- No_Articles <- NULL

  if (length(terms) == 1) {
    setNames(search_(terms, ...), 'Number of articles with search term')
  } else {
    temp <- setNames(ldply(terms, search_, ...), "No_Articles")
    temp$Term <- terms
    temp$Term <- as.character(temp$Term)
    if (vis) {
      p <- ggplot(temp, aes(x = Term, y = No_Articles)) +
        geom_bar(stat = "identity") +
        theme_grey(base_size = 18)
      return(list(table = temp, plot = p))
    }
    return( temp )
  }
}

search_ <- function(terms, ...){
  args <- ploscompact(list(q = terms, fl = "id", wt = "json"))
  tt <- GET(pbase(), query = args, ...)
  stop_for_status(tt)
  jsonlite::fromJSON(utf8cont(tt), FALSE)$response$numFound
}
