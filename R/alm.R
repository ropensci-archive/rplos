#' Retrieve PLoS article-level metrics (ALM).
#' 
#' This is the main function to search the PLoS ALM (article-level metrics) API. 
#' See details for more information.
#' 
#' @import RJSONIO RCurl plyr
#' @param doi Digital object identifier for an article in PLoS Journals (character)
#' @param pmid PubMed object identifier (numeric)
#' @param pmcid PubMed Central object identifier (numeric)
#' @param mdid Mendeley object identifier (character)
#' @param info One of summary, history, or detail(default totals + history in a list). 
#' 		Not specifying anything (the default) returns data.frame of totals across 
#' 		data providers. (character)
#' @param months Number of months since publication to request historical data for.
#' 		See details for a note. (numeric)
#' @param days Number of days since publication to request historical data for. 
#' 		See details for a note. (numeric)
#' @param year End of which year to request historical data for. 
#'   	See details for a note. (numeric)
#' @param source Name of source (or list of sources) to get ALM information for (character)
#' @param key your PLoS API key, either enter, or loads from .Rprofile (character)
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @seealso \code{\link{almplot}}
#' @details You can only supply one of the parmeters doi, pmid, pmcid, and mdid.
#' 
#' 		Query for as many articles at a time as you like. Though queries are broken
#' 		up in to smaller bits of 50 identifiers at a time.  
#' 		
#' 		If you supply days, months and/or year parameters, days takes precedence
#' 		over months and year. 		
#' @return PLoS altmetrics as data.frame's.
#' @examples \dontrun{
#' # The default call with either doi, pmid, pmcid, or mdid without specifying 
#' # an argument for info
#' alm(doi="10.1371/journal.pone.0029797")
#' 
#' # A single DOI
#' out <- alm(doi='10.1371/journal.pone.0029797', info='detail')
#' out[["totals"]] # get totals summary data.frame
#' out[["history"]] # get history summary data.frame
#' 
#' # A single PubMed ID (pmid)
#' alm(pmid=22590526)
#' 
#' # A single PubMed Central ID (pmcid)
#' alm(pmcid=212692, info='summary')
#' 
#' # A single Mendeley UUID (mdid)
#' alm(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7")
#'
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
#' 		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
#' out <- alm(doi=dois)
#' out[[1]] # get data for the first DOI
#' 
#' # Search for DOI's, then feed into alm
#' dois <- searchplos(terms='evolution', fields='id', limit = 50)
#' out <- alm(doi=as.character(dois[,1]))
#' lapply(out, head)
#' 
#' # Provide more than one pmid
#' pmids <- c(19300479, 19390606, 19343216)
#' out <- alm(pmid=pmids)
#' out[[3]] # get data for the third pmid
#' 
#' # Getting just summary data
#' alm(doi='10.1371/journal.pone.0039395', info='summary')
#' 
#' # Using days argument
#' alm(doi='10.1371/journal.pone.0040117', days=30)
#' 
#' # Using the year argument
#' alm(doi='10.1371/journal.pone.0040117', year=2012)
#' 
#' # Getting data for a specific source
#' alm(doi='10.1371/journal.pone.0035869', source='mendeley')
#' alm(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'))
#' alm(doi='10.1371/journal.pone.0035869', source=c('mendeley','twitter','counter'), info='history')
#' }
#' @export
alm <- function(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL, 
								info = "totals", months = NULL, days = NULL, year = NULL, 
								source = NULL, key = NULL, curl = getCurlHandle())
{
	url = 'http://alm.plos.org/api/v3/articles'
	
	if(!info %in% c("summary","totals","history","detail")) {
		stop("info must be one of summary, totals, history, or detail")
	}
	if(!is.null(doi))
		doi <- doi[!grepl("image", doi)] # remove any DOIs of images
	id <- compact(list(doi=doi, pmid=pmid, pmcid=pmcid, mendeley=mdid))
	
	if(length(id)>1){ stop("Only supply one of: doi, pmid, pmcid, mdid") } else { NULL }
	key <- getkey(key)
	
	if(is.null(source)){source2 <- NULL} else{ source2 <- paste(source,collapse=",") }
	
	getalm <- function() {
		if(info=="totals"){info2 <- NULL} else
			if(info=="history"|info=="detail"){info2 <- "detail"} else
				if(info=="summary"){info2 <- "summary"}
		args <- compact(list(api_key = key, info = info2, months = months, 
												 days = days, year = year, source = source2, type = names(id)))
		if(length(id[[1]])==0){stop("Please provide a DOI")} else
			if(length(id[[1]])==1){
				if(names(id) == "doi") id <- gsub("/", "%2F", id)
				args2 <- c(args, ids = id[[1]])
				out <- getForm(url, .params = args2, curl = curl)
				tt <- fromJSON(out)
				if(info=="summary"){ttt<-tt} else{ttt <- tt[[1]]$sources}
			} else
			{
				if(length(id[[1]])>1){
					if(length(id[[1]])>50){
						slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
						idsplit <- slice(id[[1]], 50)
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
						ttt <- do.call(c, temp)
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
							ttt <- lapply(tt, function(x) x$sources) 
						}
					}
				}
			}
		if(info=="summary"){ttt} else
		{
			getdata <- function(data_, y) {
				if(y == "totals"){
					servs <- sapply(data_, function(x) x$name)
					totals <- lapply(data_, function(x) x$metrics[!sapply(x$metrics, is.null)])
					names(totals) <- servs
					ldply(totals, function(x) as.data.frame(x))
				} else
				{
					servs <- sapply(data_, function(x) x$name)
					totals <- lapply(data_, function(x) x$metrics[!sapply(x$metrics, is.null)])
					names(totals) <- servs
					totalsdf <- ldply(totals, function(x) as.data.frame(x))
					
					hist <- lapply(data_, function(x) x$histories)
					gethist <- function(y) {
						dates <- sapply(y, function(x) str_split(x[[1]], "T")[[1]][[1]])
						totals <- sapply(y, function(x) x[[2]])
						data.frame(dates=dates, totals=totals)	
					}
					histdfs <- lapply(hist, gethist)
					names(histdfs) <- servs
					historydf <- ldply(histdfs)
					if(y == "history"){ historydf } else
						if(y == "detail"){ list(totals = totalsdf, history = historydf) } else
							stop("info must be one of history, event or detail")
				}
			}
			if(length(id[[1]])>1){ lapply(ttt, getdata, y=info) } else { getdata(ttt, y=info) }
		}
	}
	
	# Define safe version so errors don't prevent it from working
	safe_getalm <- plyr::failwith(NULL, getalm)
	
	# Get the data
	safe_getalm()
}