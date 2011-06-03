##### PLoS API queries code
require(RCurl)
require(stringr)
require(RJSONIO)
require(ggplot2)

########## Preparation

## Typically, a single key is associated with a single software app, which may have many users. 
## We can make it so the key doesn't have to be entered each time, see the R Mendeley package
plosapikey <- 'WQcDSXml2VSWx3P' # your api key (request yours here: http://api.plos.org/registration/)



plosapiurl <- 'http://api.plos.org/search?' # root URL for all PLoS journals
plosfields <- data(plosfields) # read in data frame describing search fields, read in as package data
# data(plosfields) # for when loading as package

journalUrls <- c( # journal specific URL's for later use in code
  PLoSBiology = 'http://www.plosbiology.org',
	PLoSGenetics = 'http://www.plosgenetics.org', 
	PLoSComputationalBiology = 'http://www.ploscompbiol.org',
	PLoSMedicine = 'http://www.plosmedicine.org',
	PLoSONE = 'http://www.plosone.org',
	PLoSNeglectedTropicalDiseases = 'http://www.plosntds.org',
	PLoSPathogens = 'http://www.plospathogens.org'
)

########## Functions
# plosfields$field # Look at possible search fields for plos journals

formatarticleurl <- function(doi, journal) {
# Function to format URL for a specific article in a specific journal
# Args:
#   doi: doi for article (numeric) 
#   journal: quoted journal name (character)
# Output: URL
# Examples:
#   myurl <- formatarticleurl(doi, 'PLoSBiology')
  paste(journalUrls[journal], '/article/info%3Adoi%2F', 
    str_replace(doi, '/', '%2F'), sep="")
}

# non-JSON
# url <- 'http://api.plos.org/search?q=drosophila&apikey=WQcDSXml2VSWx3P'
# urlout <- 
# getURL(url)

# JSON
# url <- 'http://api.plos.org/search?q=drosophila&fl=title&rows=30&dateFrom=06%2F03%2F2008&dateTo=06%2F03%2F2011&wt=json&apikey=WQcDSXml2VSWx3P'
# out <- fromJSON(url)
# length(out$response$docs)

searchplos <- function(terms, fields, limit, apikey) {
# Default function to search PLoS
# Args:
#   terms: search terms (character)
#   fields: fields to return from search (character) [e.g., 'id,title'], 
#     any combination of search fields [see plosfields$field] 
#   limit: number of results to return (integer)
#   sort: type to sort by (character), one of: 'counter_total_month', '', or ''
#   apikey: your api key (character)
# Output: URL
# Examples:
#   searchplos('drosophila', 'title', 100, plosapikey)
# terms <- 'drosophila'
# fields <- 'title'
# limit <- 100
# apikey <- plosapikey
# sort <- 'counter_total_month'
  plosapiurl <- 'http://api.plos.org/search?'
  urlstring <- paste(plosapiurl, 
    'q=', terms, 
    '&fl=', fields, 
    '&rows=', limit, 
    '&wt=json', 
#     '&sort=', sort, 
    '&apikey=', apikey, 
    sep = "")
  urlout <- fromJSON(urlstring)
  tempresults <- urlout$response$docs
  numres <- length(tempresults) # number of search results
  names(numres) <- 'Number of search results'
  dfresults <- data.frame( do.call(rbind, tempresults) )
  return(list(numres, dfresults))
}

# searchplos_author <- function(author, strict = TRUE, limit = 10, apikey) {
# # Function to search PLoS
# # Args:
# #   searchterms: search terms (character)
# #   apikey: your api key (character)
# # Output: URL
# # Examples:
# #   searchplos_author('bear', plosapikey)
#   query <- list(plosapiurl,
#     author = paste('author:', author, sep=""),
#     fl = 'id,journal,title', 
#     rows = limit,
#     api_key = plosapikey)
#   toJSON(query) 
# }
