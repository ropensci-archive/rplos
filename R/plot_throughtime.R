# Function to plot results through time for serach results from PLoS Journals

plot_throughtime <- 
# Args:
#   terms: search terms (character)
#   limit: number of results to return (integer)
# Examples:
#   plot_throughtime('phylogeny', 300)
#   plot_throughtime(list('drosophila','monkey'), 500)

function(terms, limit = NA, 
  url = "http://api.plos.org/search",
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) 
{
  if (length(terms) == 1) {
  args <- list(apikey = key)
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
  tt_dt <- data.table(tt_)
  tsum <- as.data.frame(tt_dt[, length(year), by=list(year, month)])
  tsum$dateplot <- as.Date(paste(tsum$month, "1", 
    str_sub(tsum$year, 3, 4), sep="/"), "%m/%d/%y")
  p <- ggplot(tsum, aes(x = dateplot, y = V1)) + 
    geom_line(colour = "red") +
    theme_bw() +
    labs(x = "", y = "Number of articles matching search term(s)\n") +
    opts(title = paste("PLoS search of", terms, "using the rplos package"))
  return(p)
  }
  else {
  search_ <- function(x) {
      args <- list(apikey = key)
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
      tt_dt <- data.table(tt_)
      tsum <- as.data.frame(tt_dt[, length(year), by=list(year, month)])
    return(tsum)
    }
  temp <- llply(terms, search_)
  temp2 <- merge(temp[[1]], temp[[2]], by=c("year", "month"), 
    all=T, suffixes=terms)
  temp2$dateplot <- as.Date(paste(temp2$month, "1", 
    str_sub(temp2$year, 3, 4), sep="/"), "%m/%d/%y")
  temp2m <- melt(temp2[, -c(1:2)], id = 3)
  pp <- ggplot(temp2m, aes(x = dateplot, y = value, group = variable, colour = variable)) + 
    geom_line() +
    theme_bw() +
    labs(x = "", y = "Number of articles matching search term(s)\n") +
    opts(title = paste("PLoS search of", paste(as.character(terms), collapse=","), "using the rplos package"),
      legend.position = c(0.35, 0.8))
  return(pp)
  }
}