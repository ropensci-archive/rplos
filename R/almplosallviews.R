# plosallviews.R

plosallviews <- 
# Function htmlviews to summarise all pdf, html, and xml views
# Args:
#   doi: digital object identifier for an article in PLoS Journals  (string)
#   source_ (character): Five categories of sources
#     Usage stats: counter [PLoS' own stats], pmc [PubMed].
#     Citations: pubmed, crossref, scopus, or wos [Web of Science].
#     Social: citeulike.
#     Blog entries: nature (no. of Nature blog articles that mentioned the article).
#     Inactive sources: researchblogging, connotea, bloglines, postgenomic
#   citations: include the individual citing document URIs, grouped by source,
#     TRUE (T) or FALSE (F) (character)
#   history: include a historical record of citation counts per month (cumulative), 
#     grouped by source, TRUE (T) or FALSE (F) (character)
#   downform: download format (json, xml or csv)
# Examples: 
#   plosallviews('10.1371/journal.pbio.0000012', 'counter', T, T, 'xml')
#   plosallviews('10.1371/journal.pbio.0000012', 'citeulike', T, T, 'json')
#   plosallviews('10.1371/journal.pone.0005723', 'counter', T, T, 'csv')

function(doi, source_ = NA, citations = FALSE, history = FALSE, downform = NA,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ..., 
  curl = getCurlHandle() ) {

  if(! downform == 'csv') {  
    url2 <- paste(url, "/", doi, '.', downform, sep='')
    args <- list(api_key = key)
    if(!is.na(source_))
      args$source <- source_
    if(!citations == FALSE)
      args$citations <- 1
    if(!history == FALSE)
      args$history <- 1
    tt <- getForm(url2, 
      .params = args, 
      ..., 
      curl = curl)
    if(downform == 'json') {outprod <- fromJSON(I(tt))} else
      if(downform == 'xml') {outprod <- xmlTreeParse(I(tt))}
  } else
  outprod <- cat("No support for CSV downloads at the moment - apologies")
#   { if(is.na(source_)) {source2 <- NULL} else
#       {source2 <- paste('source=', source_, sep='')}
#     if(citations == FALSE) {citations2 <- NULL} else
#       {citations2<-paste('&citations=1')}
#     if(history == FALSE) {history2 <- NULL}
#       {history2 <- paste('&history=1')}
#     urlcsv <- paste(url, "/", doi, '.', downform, '?', source2, 
#       citations2, history2, '&api_key=', key, sep='')
#     outprod <- read.csv(urlcsv)
#   }
  
return(outprod)
}