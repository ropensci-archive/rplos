#' Get the date when the article was published.
#' @import RJSONIO RCurl
#' @param doi Digital object identifier for an article in PLoS Journals
#' @param get Get year, month, or day; if unspecified, whole date returned.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Date when article was published.
#' @export
#' @examples \dontrun{
#' almdatepub('10.1371/journal.pone.0026871')
#' almdatepub('10.1371/journal.pone.0026871', 'year')
#' }
almdatepub <- 

function(doi, get = NA,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) {
    
  url2 <- paste(url, "/", doi, '.json?api_key=', key, sep='')
  tt <- getURLContent(url2)
  date <- fromJSON(I(tt))$article$published
  date_vector <- str_split(str_split(aa, "T")[[1]][1], "-")[[1]]
  if(is.na(get) == TRUE) {str_split(aa, "T")[[1]][1]} else
    if(get == 'year') {as.numeric(date_vector[1])} else
      if(get == 'month') {as.numeric(date_vector[2])} else
        if(get == 'day') {as.numeric(date_vector[3])}
}