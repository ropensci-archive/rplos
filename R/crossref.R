#' Lookup article info via CrossRef with DOI.
#' @import RCurl XML
#' @param doi digital object identifier for an article in PLoS Journals
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Metadata from DOI.
#' @export
#' @examples \dontrun{
#' crossref("10.3998/3336451.0009.101")
#' }
crossref <- 

function(doi, 
  url = "http://www.crossref.org/openurl/", 
  key = getOption("CrossRefKey", stop("need an API key for Mendeley")), 
  ...,
  curl = getCurlHandle())
{
  ## Assemble a url query such as:
  #http://www.crossref.org/openurl/?id=doi:10.3998/3336451.0009.101&noredirect=true&pid=API_KEY&format=unixref
  args = list(id = paste("doi:", doi, sep="") )
  args$pid = as.character(key)
  args$noredirect=as.logical(TRUE)
  args$format=as.character("unixref")
  tt = getForm(url, .params = args, .opts = list(...), curl = curl)
  ans = xmlParse(tt)
## should really return the content of other nodes too, but this is the important one.  
  nodeset = getNodeSet(ans, "//journal_article")
  lapply(nodeset, xmlToList)
}