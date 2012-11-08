#' Get title of article by inputting the doi for the article.
#' 
#' @import RJSONIO RCurl
#' @param doi digital object identifier for an article in PLoS Journals
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Title of article, in xml format.
#' @examples \dontrun{
#' almtitle(doi='10.1371/journal.pbio.0000012')
#' }
#' @export
almtitle <- function(doi, url = 'http://alm.plos.org/api/v3/articles',
	key = NULL, curl = getCurlHandle() ) 
{ 
	key <- getkey(key)
	doi <- paste("doi/", doi, sep="")
	doi2 <- gsub("/", "%2F", doi)
	url2 <- paste(url, "/info%3A", doi2, '?api_key=', key, '&info=summary', sep='')
	tt <- fromJSON(url2)
	str_replace_all(tt$article$title, "<(.|\n)*?>", "")
}