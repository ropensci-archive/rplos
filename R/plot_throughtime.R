#' Plot results through time for serach results from PLoS Journals.
#'
#' @export
#' @param terms search terms (character)
#' @param limit number of results to return (integer)
#' @param ... optional additional curl options (debugging tools mostly)
#' @return Number of search results (vis = FALSE), or number of search in a table
#'    and a histogram of results (vis = TRUE).
#' @examples \dontrun{
#' plot_throughtime(terms='phylogeny', limit=300)
#' plot_throughtime(list('drosophila','monkey'), 100)
#' plot_throughtime(list('drosophila','flower','dolphin','cell','cloud'), 100)
#' }

plot_throughtime <- function(terms, limit = NA, ...) {
  ## avoid false positive 'unreferenced variable' warnings
  year = month = dateplot = V1 = value = variable = NULL
  temp <- lapply(terms, timesearch, limit = limit, ...)
  ij <- function(...) left_join(..., by = c("year", "month"))
  df <- setNames(Reduce(ij, temp), c("year", "month", terms))
  df$dateplot <- as.Date(paste(df$month, "1",
                               substring(df$year, 3, 4), sep = "/"), "%m/%d/%y")
  dfm <- melt(df[, -c(1:2)], id.vars = "dateplot")
  dfm$value <- as.numeric(dfm$value)
  pp <- ggplot(dfm, aes(x = dateplot, y = value, group = variable, colour = variable)) +
    geom_line(size = 2) +
    scale_colour_brewer(palette = "Dark2") +
    labs(x = "", y = "Number of articles matching search term(s)\n",
         title = paste("PLoS search of", paste(as.character(terms), collapse = ","), "using the rplos package")) +
    theme(legend.position = c(0.35, 0.8))
  return(pp)
}

timesearch <- function(terms, limit, ...){
  month <- NULL
  args <- ploscompact(list(q = terms, fl = "publication_date", wt = "json", rows = limit))
  tt <- GET(pbase(), query = args, ...)
  stop_for_status(tt)
  res <- utf8cont(tt)
  json <- jsonlite::fromJSON(res, FALSE)
  tempresults <- json$response$docs
  ttt <- data.frame( do.call(rbind, tempresults), stringsAsFactors = FALSE )
  tt_ <- setNames(as.data.frame(t(apply(ttt, 1, function(x) strsplit(x[[1]], "-")[[1]][1:2])), stringsAsFactors = FALSE), c("year", "month"))
  ddply(tt_, c('year','month'), summarise, V1 = length(month))
}
