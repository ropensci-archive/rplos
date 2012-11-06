#' Get PLoS altmetrics as xml, json, or csv.
#' 
#' See details for more information.
#' 
#' @import RJSONIO RCurl plyr
#' @param doi digital object identifier for an article in PLoS Journals
#' @param info One of summary or detail (character)
#' @param months Number of months since publication to request historical data for.
#' @param days Number of days since publication to request historical data for.
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @details By default, this function now returns json. Other data return 
#' 		formats have been removed for simplicity. Get in touch if you want them 
#' 		added back. Queries for up to 100 articles at a time are supported.
#' @return PLoS altmetrics as raw json or as list object.
#' @examples \dontrun{
#' # A single DOI
#' out <- almplosallviews(doi='10.1371/journal.pone.0029797', info='detail')
#' out[["metrics"]] # get metrics summary data.frame
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#' 		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- almplosallviews(doi=dois, info="detail")
#' out[[1]][["metrics"]]
#' 
#' # Getting just summary data
#' almplosallviews(doi='10.1371/journal.pone.0039395', info='summary')
#' dois <- c('10.1371/journal.pone.0040117',
#' 		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' almplosallviews(doi=dois, info="detail")
#' 
#' # Using month and day arguments
#' out <- almplosallviews(doi='10.1371/journal.pone.0040117', days=30)
#' }
#' @export
almplosallviews <- function(doi, info = "detail", months = NULL, days = NULL, 
	url = 'http://alm.plos.org/api/v3/articles', key = NULL, curl = getCurlHandle())
{
	key <- getkey(key)
	doit <- function() {
		args <- compact(list(api_key = key, info = info, months = months, days = days))
		if(length(doi)==0){stop("Please provide a DOI")} else
			if(length(doi)==1){
				doi <- paste("doi/", doi, sep="")
				doi2 <- gsub("/", "%2F", doi)
				url2 <- paste(url, "/info%3A", doi2, sep='')
				out <- getForm(url2, .params = args, curl = curl)
				tt <- fromJSON(out)
				if(info=="summary"){ttt<-tt} else{ttt <- tt[[1]]$sources}
			} else
				if(length(doi)>1){
					doi2 <- paste(sapply(doi, function(x) gsub("/", "%2F", x)), collapse=",")
					args2 <- c(args, ids = doi2)
					out <- getForm(url, .params = args2, curl = curl)
					tt <- fromJSON(out)
					if(info=="summary"){ttt<-tt} else { 
						ttt <- lapply(tt, function(x) x$article$sources) 
					}
				}
		if(info=="summary"){ttt} else
		{
			getdata <- function(data_) {
				servs <- sapply(data_, function(x) x$source$name)
				metrics <- lapply(data_, function(x) x$source$metrics[!sapply(x$source$metrics, is.null)])
				names(metrics) <- servs
				metricsdf <- ldply(metrics, function(x) as.data.frame(x))
				
				hist <- lapply(data_, function(x) x$source$histories)
				gethist <- function(y) {
					dates <- sapply(y, function(x) str_split(x[[1]], "T")[[1]][[1]])
					totals <- sapply(y, function(x) x[[2]])
					data.frame(dates=dates, totals=totals)	
				}
				histdfs <- lapply(hist, gethist)
				names(histdfs) <- servs
				historydf <- ldply(histdfs)
# 				historydf$dates <- as.Date(historydf$dates)
				
				list(metrics = metricsdf, history = historydf)
			}
			if(length(doi)>1){ lapply(ttt, getdata) } else { getdata(ttt) }
		}
	}
	safe_doit <- plyr::failwith(NULL,doit)
	safe_doit()
}