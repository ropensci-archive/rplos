#' Lookup article info via CrossRef with DOI.
#' 
#' @import RCurl XML
#' @param doi digital object identifier for an article in PLoS Journals
#' @param title return the title of the paper or not (defaults to FALSE)
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Metadata from DOI in R's bibentry format.
#' @examples \dontrun{
#' crossref(doi="10.1371/journal.pone.0042793")
#' print(crossref("10.3998/3336451.0009.101"), style="Bibtex")
#' print(crossref("10.3998/3336451.0009.101"), style="text")
#' }
#' @export
crossref <- function(doi, title = FALSE, url = "http://www.crossref.org/openurl/", 
	key = "cboettig@gmail.com", ..., curl = getCurlHandle())
{
  ## Assemble a url query such as:
  #http://www.crossref.org/openurl/?id=doi:10.3998/3336451.0009.101&noredirect=true&pid=API_KEY&format=unixref
  args = list(id = paste("doi:", doi, sep="") )
  args$pid = as.character(key)
  args$noredirect=as.logical(TRUE)
  args$format=as.character("unixref")
  tt = getForm(url, .params = args, 
#   						 .opts = list(...), 
  						 curl = curl)
  ans = xmlParse(tt)
  formatcrossref(ans)
}


#' Convert crossref XML into a bibentry object
#' 
#' @param a crossref XML output
#' @return a bibentry format of the output
#' @details internal helper function
formatcrossref <- function(a){
 authors <- person(family=as.list(xpathSApply(a, "//surname", xmlValue)),
                  given=as.list(xpathSApply(a, "//given_name", xmlValue)))
  rref <- bibentry(
        bibtype = "Article",
        title = check_missing(xpathSApply(a, "//titles/title", xmlValue)),
        author = check_missing(authors),
        journal = check_missing(xpathSApply(a, "//full_title", xmlValue)),
        year = check_missing(xpathSApply(a, 
          "//journal_article/publication_date/year", xmlValue)[[1]]),
        month =xpathSApply(a, 
          "//journal_article/publication_date/month", xmlValue),
        volume = xpathSApply(a, "//journal_volume/volume", xmlValue),
        doi = xpathSApply(a, "//journal_article/doi_data/doi", xmlValue)
#         issn = xpathSApply(a, "//issn[@media_type='print']", xmlValue)
#        url = xpathSApply(a, "//journal_article/doi_data/resource", xmlValue)
        )
 rref
}

# Title, author, journal, & year cannot be missing, so return "NA" if they are
# Avoid errors in bibentry calls when a required field is not specified.   
check_missing <- function(x){
 if(length(x)==0)
  out <- "NA"
 else 
  out <- x
  out
}