#' Lookup article info via CrossRef with DOI.
#' 
#' @rdname crossref-defunct
#' @keywords internal
crossref <- function(...)
{
  .Defunct("rcrossref", "Crossref functionality moved to package rcrossref")
  
	url = "http://www.crossref.org/openurl/"
	
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
