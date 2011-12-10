#' formatarticleurl.R   format a URL for a specific article in a specific journal
#' @param doi digital object identifier for an article in PLoS Journals
#' @param journal quoted journal name (character)
#' @return get url for the article to use in your browser, etc
#' @examples \dontrun{
#'  formatarticleurl("10.1371/journal.pone.0004045", 'PLoSONE')
#' }
#' @export
formatarticleurl <- 

function(doi, journal) 
{
  paste(journalUrls[journal], '/article/info%3Adoi%2F', 
    str_replace(doi, '/', '%2F'), sep="")
}