#' almtitle.R   Alt-metrics title of article
#' @param doi digital object identifier for an article in PLoS Journals
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return title of article
#' @examples \dontrun{
#'    almtitle('10.1371/journal.pbio.0000012')
#' }
#' @export
almtitle <- 

function(doi,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) {
    
  url2 <- paste(url, "/", doi, '.json?api_key=', key, sep='')
  tt <- getURLContent(url2)
  fromJSON(I(tt))$article$title
}