#' Plot results through time for serach results from PLoS Journals.
#' 
#' @import RJSONIO RCurl ggplot2
#' @importFrom googleVis gvisMotionChart
#' @importFrom stringr str_split str_sub
#' @importFrom plyr ddply llply
#' @importFrom reshape2 melt
#' @param terms search terms (character)
#' @param limit number of results to return (integer)
#' @param gvis use google visualization via the googleVis package (logical)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (vis = FALSE), or number of search in a table
#'    and a histogram of results (vis = TRUE).
#' @examples \dontrun{
#' plot_throughtime('phylogeny', 300)
#' plot_throughtime(list('drosophila','monkey'), 100)
#' plot_throughtime(list('drosophila','flower'), 100, TRUE)
#' }
#' @export
plot_throughtime <- function(terms, limit = NA, gvis = FALSE,
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., curl = getCurlHandle() ) 
{
  ## avoid false positive 'unreferenced variable' warnings
  year=NULL; month=NULL;
  dateplot=NULL; 
  V1=NULL; value=NULL; variable=NULL

	url = "http://api.plos.org/search"
	
  if (length(terms) == 1) {
  args <- list(api_key = key)
  if(!is.na(terms))
    args$q <- terms
  if(!is.na(limit))
    args$rows <- limit
  args$fl <- "publication_date"
  args$wt <- "json"
  tt <- getForm(url, 
    .params = args,
    ...,
    curl = curl)
  jsonout <- fromJSON(I(tt))
  tempresults <- jsonout$response$docs
  ttt <- data.frame( do.call(rbind, tempresults) )
  tt_ <- as.data.frame(t(apply(ttt, 1, function(x) str_split(x[[1]], 
    pattern = "-")[[1]][1:2])))
  names(tt_) <- c("year", "month")
  tsum <- ddply(tt_, c('year','month'), summarise, V1 = length(month))
  tsum$dateplot <- as.Date(paste(tsum$month, "1", 
    str_sub(tsum$year, 3, 4), sep="/"), "%m/%d/%y")
  tsum$V1 <- as.numeric(tsum$V1)
  p <- ggplot(tsum, aes(x = dateplot, y = V1)) + 
    geom_line(colour = "red") +
    theme_bw() +
    labs(x = "", y = "Number of articles matching search term(s)\n", 
    		 title = paste("PLoS search of ", terms, " using the rplos package"))
  return(p)
  }
  else {
  search_ <- function(x) {
      args <- list(api_key = key)
      if(!is.na(x))
        args$q <- x
      if(!is.na(limit))
        args$rows <- limit
      args$fl <- "publication_date"
      args$wt <- "json"
      tt <- getForm(url, 
        .params = args,
        ...,
        curl = curl)
      jsonout <- fromJSON(I(tt))
      tempresults <- jsonout$response$docs
      ttt <- data.frame( do.call(rbind, tempresults) )
      tt_ <- as.data.frame(t(apply(ttt, 1, function(x) str_split(x[[1]], 
        pattern = "-")[[1]][1:2])))
      names(tt_) <- c("year", "month")
      tsum <- ddply(tt_, c('year','month'), summarise, V1 = length(month))
    return(tsum)
    }
  temp <- llply(terms, search_)
  temp2 <- merge(temp[[1]], temp[[2]], by=c("year", "month"), 
    all=TRUE, suffixes=terms)
  temp2$dateplot <- as.Date(paste(temp2$month, "1", 
    str_sub(temp2$year, 3, 4), sep="/"), "%m/%d/%y")
  temp2m <- melt(temp2[, -c(1:2)], id = 3)
  temp2m$value <- as.numeric(temp2m$value)
    if(gvis == "FALSE") {
      pp <- ggplot(temp2m, aes(x = dateplot, y = value, group = variable, colour = variable)) + 
        geom_line() +
        theme_bw() +
        labs(x = "", y = "Number of articles matching search term(s)\n",
        		 title = paste("PLoS search of", paste(as.character(terms), collapse=","), "using the rplos package")) +
        theme(legend.position = c(0.35, 0.8))
      return(pp)
      }
    else {
      gvisplot <- gvisMotionChart(temp2m, idvar="variable", timevar="dateplot")
      plot(gvisplot)  
    }
  }
}
