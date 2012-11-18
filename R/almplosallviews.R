#' Get PLoS altmetrics as xml, json, or csv.
#' 
#' See details for more information.
#' 
#' @import RJSONIO RCurl plyr
#' @param doi Digital object identifier for an article in PLoS Journals
#' @param pmid PubMed object identifier
#' @param pmcid PubMed Central object identifier
#' @param mdid Mendeley object identifier
#' @param info One of summary or detail (character)
#' @param months Number of months since publication to request historical data for.
#' 		See details for a note.
#' @param days Number of days since publication to request historical data for. 
#' 		See details for a note.
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @details You can only supply one of the parmeters doi, pmid, pmcid, and mdid.
#' 	
#' 		By default, this function now returns json. Other data return 
#' 		formats have been removed for simplicity. Get in touch if you want them 
#' 		added back. 
#' 		
#' 		Queries for up to 100 articles at a time will be supported soon. 
#' 		
#' 		If you supply both the days and months parameters, days takes precedence,
#' 		and months is ignored. 		
#' @return PLoS altmetrics as raw json or as list object.
#' @examples \dontrun{
#' # A single DOI
#' out <- almplosallviews(doi='10.1371/journal.pone.0029797', info='detail')
#' out[["metrics"]] # get metrics summary data.frame
#' out[["history"]] # get metrics summary data.frame
#' 
#' # A single PubMed ID (pmid)
#' almplosallviews(pmid=22590526, info='detail')
#' 
#' # A single PubMed Central ID (pmcid)
#' almplosallviews(pmcid=212692, info='summary')
#' 
#' # A single Mendeley UUID (mdid)
#' almplosallviews(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7", info='summary')
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#' 		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- almplosallviews(doi=dois, info="detail")
#' out[[1]][["metrics"]] # get data for the first DOI, and just the monthly avg. metrics
#' 
#' # Provide more than one pmid
#' pmids <- c(19300479, 19390606, 19343216)
#' out <- almplosallviews(pmid=pmids, info="detail")
#' out[[3]][["metrics"]] # get data for the third pmid, and just the monthly avg. metrics
#' 
#' # Getting just summary data
#' almplosallviews(doi='10.1371/journal.pone.0039395', info='summary')
#' 
#' # Using month and day arguments
#' out <- almplosallviews(doi='10.1371/journal.pone.0040117', days=30)
#' }
#' @export
almplosallviews <- function(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL, 
	info = "detail", months = NULL, days = NULL, 
	url = 'http://alm.plos.org/api/v3/articles', key = NULL, curl = getCurlHandle())
{
	id <- compact(list(doi=doi, pmid=pmid, pmcid=pmcid, mendeley=mdid))
	if(length(id)>1){ stop("Only supply one of: doi, pmid, pmcid, mdid") } else { NULL }
	key <- getkey(key)
	doit <- function() {
		args <- compact(list(api_key = key, info = info, months = months, 
												 days = days, type = names(id)))
		if(length(id[[1]])==0){stop("Please provide a DOI")} else
			if(length(id[[1]])==1){
				if(names(id) == "doi") id <- gsub("/", "%2F", id)
				args2 <- c(args, ids = id[[1]])
				out <- getForm(url, .params = args2, curl = curl)
				tt <- fromJSON(out)
				if(info=="summary"){ttt<-tt} else{ttt <- tt[[1]]$article$sources}
			} else
				if(length(id[[1]])>1){
					if(length(id[[1]])>100){
						slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
						idsplit <- slice(id, 100)
						repeatit <- function(y) {
							if(names(id) == "doi"){ 
								id2 <- paste(sapply(y, function(x) gsub("/", "%2F", x)), collapse=",")
							} else
								{
									id2 <- paste(id[[1]], collapse=",")
								}
							args2 <- c(args, ids = id2)
							out <- getForm(url, .params = args2, curl = curl)
							tt <- fromJSON(out)
							if(info=="summary"){tt} else { 
								lapply(tt, function(x) x$article$sources) 
							}
						}
						temp <- lapply(idsplit, repeatit)
						ttt <- unlist(temp, recursive=T, use.names=F)
					} else {
						if(names(id) == "doi") {
							id2 <- paste(sapply(id, function(x) gsub("/", "%2F", x)), collapse=",")
						} else
							{
								id2 <- paste(id[[1]], collapse=",")
							}
						args2 <- c(args, ids = id2)
						out <- getForm(url, .params = args2, curl = curl)
						tt <- fromJSON(out)
						if(info=="summary"){ttt<-tt} else { 
							ttt <- lapply(tt, function(x) x$article$sources) 
						}
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
			if(length(id[[1]])>1){ lapply(ttt, getdata) } else { getdata(ttt) }
		}
	}
	safe_doit <- plyr::failwith(NULL,doit)
	safe_doit()
}