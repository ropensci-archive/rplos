# almpubmedcentid.R

almpubmedcentid <- 
# Function retrieves the PubMed Central article ID
# Args:
#   doi: digital object identifier for an article in PLoS Journals  (string)
# Examples: 
#   almpubmedcentid('10.1371/journal.pbio.0000012')

function(doi,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) {
    
  url2 <- paste(url, "/", doi, '.json?api_key=', key, sep='')
  tt <- getURLContent(url2)
  outprod <- fromJSON(I(tt))$article$pub_med_central

  return(outprod)
}