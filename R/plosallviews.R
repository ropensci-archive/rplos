# plosallviews.R

plosallviews <- 
# Function htmlviews to summarise all pdf, html, and xml views
# Examples: 
#   plosallviews('10.1371/journal.pbio.0000012', 'counter', 'json')  

function(doi, source_ = NA, downform = NA,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) {

  url2 <- paste(url, "/", doi, '.', downform, sep='')
  args <- list(api_key = key, citations = 1)
  if(is.na(source_)) {source_ <- NULL} else
    {args$source <- source_}    
  tt <- getForm(url2, 
    .params = args, 
#     ..., 
    curl = curl)
  jsonout <- fromJSON(I(tt))
  return(jsonout)
}
# source2 <- 'counter'
# doi3 <- '10.1371/journal.pbio.0000012'
# downform2 <- 'json'
# key <- 'WQcDSXml2VSWx3P'
# out <- plosallviews(doi3, source2, downform2)