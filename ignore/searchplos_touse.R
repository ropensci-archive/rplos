# req(list("RCurl","RJSONIO","stringr","plyr","doMC"))
#' Base function to hit the PLoS Journals Search API.
#' 
#' @import RJSONIO RCurl stringr plyr
#' @param terms Search terms (character)
#' @param fields Fields to return from search (character) (e.g., c('id','title')), 
#'    any combination of search fields (type 'data(plosfields)', then 
#'    'plosfields').
#' @param toquery List specific fields to query (if NA, all queried).
#' @param start record to start at (used in combination with limit when 
#' you need to cycle through more results than the max allowed=1000)
#' @param limit number of results to return (integer)
#' @param returndf Return data.frame of results or not (defaults to TRUE).
#' @param url the PLoS API url for the function (should be left to default)
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#' @return Number of search results (vis = FALSE), or number of search in a table
#'    and a histogram of results (vis = TRUE).
#' @examples \dontrun{
#' mydat <- searchplos(terms='science', fields=c('id','journal','volume','pagecount','editor'), returndf = T)
#' mydat[[2]] # return just the data
#' searchplos(terms='ecology', fields=c('id','publication_date'), limit = 2, returndf = TRUE)
#' searchplos(terms='ecology', fields='id', limit = 100)
#' searchplos(terms='ecology', fields=c('id','title','author','pagecount'), limit = 200, returndf=F)
#' searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
#' searchplos(terms="*:*", fields='id', toquery='cross_published_journal_key:PLoSONE', start=0, limit=250)
#' searchplos(terms="*:*", fields='id', toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), start=0, limit=250)
#' }
#' @export
searchplos <- function(terms = NA, fields = NA, toquery = NA, start = 1, 
		limit = NA, returndf = TRUE, url = 'http://api.plos.org/search',
		key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
		..., curl = getCurlHandle()) 
{
	insertnones <- function(x) {
		toadd <- fields[! fields %in% names(x) ]
		values <- rep("none", length(toadd))
		names(values) <- toadd
		values <- as.list(values)
		x <- c(x, values)
		x
	}
	if(is.na(limit)){limit <- 999} else{limit <- limit}
	args <- list()
	if(!is.na(toquery[[1]])) {
		if(length(toquery)==1) {args$fq <- toquery} else
		{args <- list(fq=toquery[[1]], fq=toquery[[2]])} } else
			NULL
	args$api_key <- key
	if(!is.na(terms))
		args$q <- terms
	if(!any(is.na(fields)))
		args$fl <- paste(fields, collapse=",")
	if(!is.na(start))
		args$start <- start
	if(!is.na(limit))
		args$rows <- limit
	args$wt <- "json"

	argsgetnum <- list(q=terms, rows=0, wt="json", api_key=key)
	getnum <- getForm(url, 
		.params = argsgetnum,
		curl = curl)
	getnumrecords <- fromJSON(I(getnum))$response$numFound
	if(getnumrecords > limit){getnumrecords <- limit} else{getnumrecords <- getnumrecords}

	if(min(limit,getnumrecords) < 1000) {
		if(!is.na(limit))
			args$rows <- limit
		tt <- getForm(url, 
			.params = args,
			#...,
			curl = curl)
		jsonout <- fromJSON(I(tt))
		tempresults <- jsonout$response$docs
		numres <- length(tempresults) # number of search results 
		names(numres) <- 'Number of search results'
		tempresults <- llply(tempresults, insertnones, .inform=T)
		if(returndf == TRUE){
			tempresults_ <- data.frame(do.call(rbind, tempresults))
			tempresults_ <- colClasses(tempresults_, rep(c("factor"), ncol(tempresults_)))
		} else
			{tempresults_ <- tempresults}
		return(list(numres, tempresults_))  
	} else
	{ 
		getvecs <- seq(from=1, to=getnumrecords, by=500)
		lastnum <- as.numeric(str_extract(getnumrecords, "[0-9]{3}$"))-1
		if(lastnum > 500){
			lastnum <- getnumrecords-getvecs[length(getvecs)]
		} else 
			{lastnum <- lastnum}
		getrows <- c(rep(500, length(getvecs)-1), lastnum)
#		dfinput <- data.frame(getvecs, getrows)
		out <- list()
		for(i in 1:length(getvecs)) {
			cat(i,"\n")
			args$start <- getvecs[i]
			args$rows <- getrows[i]
			tt <- getForm(url, 
				.params = args,
       	#		...,
				curl = curl)
			jsonout <- fromJSON(I(tt))
			tempresults <- jsonout$response$docs 
			tempresults <- llply(tempresults, insertnones)
			out[[i]] <- tempresults
		}
#		getres <- function(x, y) {
#		 	args$start <- x
#			args$rows <- y
#			tt <- getForm(url, 
#				.params = args,
#				curl = curl)
#			jsonout <- fromJSON(tt)
#			tempresults <- jsonout$response$docs 
#			llply(tempresults, insertnones)
#		}
#		if(parallel == TRUE){
#			registerDoMC(cores=cores)
#			out <- llply(split(dfinput, row.names(dfinput)), function(x) getres(x[,1], x[,2]), .parallel=T)
#		} else
#			{
#				out <- llply(split(dfinput, row.names(dfinput)), function(x) getres(x[,1], x[,2]), .inform=T)
#			}
		if(returndf == TRUE){
			results_ <- ldply(out, 
				function(x) data.frame(do.call(rbind, x)))
			results_ <- colClasses(results_, rep(c("factor"), ncol(results_)))
		} else
			{results_ <- out}
		names(getnumrecords) <- 'Number of search results'
		return(list(getnumrecords, results_))
	}
}