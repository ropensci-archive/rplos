#' Get PLoS altmetrics as xml, json, or csv.
#' 
#' @import RJSONIO XML RCurl plyr
#' @param doi digital object identifier for an article in PLoS Journals
#' @param source_ source, one of counter, mpc, pubmed, crossref, scopus, wos,
#'    citeulike, nature, researchblogging, connotea, bloglines, postgenomic
#' @param events include the individual citing document URIs, grouped by
#'    source (logical)
#' @param history include a historical record of citation counts per month
#'    (cumulative), grouped by source (logical)
#' @param downform download format (json, xml or csv)
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @return PLoS altmetrics as xml, json, or csv.
#' @examples \dontrun{
#' almplosallviews('10.1371/journal.pbio.0000012', 'counter', 1, 1, 'xml')
#' almplosallviews('10.1371/journal.pbio.0000012', 'crossref', 1, 0, 'json')
#' almplosallviews('10.1371/journal.pbio.0000012', 'citeulike', 0, 0, 'json')
#' almplosallviews('10.1371/journal.pone.0002554', 'facebook', 1, 1, 'json')
#' almplosallviews('10.1371/journal.pone.0002554', 'mendeley', 0, 1, 'json')
#'
#' # DOI that does not work, gives NA so that looping isn't interrupted
#' almplosallviews("10.1371/journal.pone.002699", 'citeulike', F, F, 'json')
#' }
#' @export
almplosallviews <- function(doi, source_ = NULL, events = NULL, history = NULL, 
	downform = NA, sleep = 0, url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ...,
  curl = getCurlHandle() ) 
{
  Sys.sleep(sleep)
  if(! downform == 'csv') {
    url2 <- paste(url, "/", doi, '.', downform, sep='')
#     args <- list(api_key = key)
#     if(!is.na(source_))
#       args$source <- source_
#     if(!events == FALSE)
#       args$events <- 1
#     if(!history == FALSE)
#       args$history <- 1
    args <- compact(list(api_key = key, source = source_, events = events, 
    										 history = history))
    if(class(try(getForm(url2, .params = args, ..., curl = curl),
          silent = T ) ) %in% 'try-error')
      { outprod <- NA } else
        { tt <-  getForm(url2, .params = args, ..., curl = curl)
            if(downform == 'json') {outprod <- fromJSON(I(tt))} else
              if(downform == 'xml') {outprod <- xmlTreeParse(I(tt))}
        }
  } else
  outprod <- cat("No support for CSV downloads at the moment - apologies")
#   { if(is.na(source_)) {source2 <- NULL} else
#       {source2 <- paste('source=', source_, sep='')}
#     if(events == FALSE) {events2 <- NULL} else
#       {events2<-paste('&events=1')}
#     if(history == FALSE) {history2 <- NULL}
#       {history2 <- paste('&history=1')}
#     urlcsv <- paste(url, "/", doi, '.', downform, '?', source2,
#       events2, history2, '&api_key=', key, sep='')
#     outprod <- read.csv(urlcsv)
#   }
  outprod
}