#' Get the date when article was last updated.
#' 
#' @import RJSONIO RCurl
#' @param doi Digital object identifier for an article in PLoS Journals.
#' @param get Get year, month, or day; if unspecified, whole date returned.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @return Date when article data was last updated.
#' @examples \dontrun{
#' almdateupdated('10.1371/journal.pone.0026871')
#' almdateupdated('10.1371/journal.pone.0026871', 'year')
#' }
#' @export
almdateupdated <-

function(doi, get = NA,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ...,
  curl = getCurlHandle() ) 
{
#   url2 <- paste(url, "/", doi, '.json?api_key=', key, sep='')
#   tt <- getURLContent(url2)
#   date <- fromJSON(I(tt))$article$updated_at
#   date_vector <- str_split(str_split(date, "T")[[1]][1], "-")[[1]]
#   if(is.na(get) == TRUE) {str_split(date, "T")[[1]][1]} else
#     if(get == 'year') {as.numeric(date_vector[1])} else
#       if(get == 'month') {as.numeric(date_vector[2])} else
#         if(get == 'day') {as.numeric(date_vector[3])}
	message("Deprecated - duplicate of almupdated")
}