#' Retrieve PLoS article-level metrics (ALM) events.
#' 
#' Events are the details of the metrics that are counted related to PLoS papers.
#' 
#' @import RJSONIO RCurl plyr reshape
#' @param doi Digital object identifier for an article in PLoS Journals (character)
#' @param pmid PubMed object identifier (numeric)
#' @param pmcid PubMed Central object identifier (numeric)
#' @param mdid Mendeley object identifier (character)
#' @param months Number of months since publication to request historical data for.
#' 		See details for a note. (numeric)
#' @param days Number of days since publication to request historical data for. 
#' 		See details for a note. (numeric)
#' @param key your PLoS API key, either enter, or loads from .Rprofile (character)
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @details You can only supply one of the parmeters doi, pmid, pmcid, and mdid.
#' 		
#' 		Query for as many articles at a time as you like. Though queries are broken
#' 		up in to smaller bits of 30 identifiers at a time. 
#' 		
#' 		If you supply both the days and months parameters, days takes precedence,
#' 		and months is ignored.
#' 		
#' 		You can get events from many different sources. After calling almevents, 
#' 		then index the output by the data provider you want. The options are:
#' 		bloglines, citeulike, connotea, crossref, nature, postgenomic, pubmed, 
#' 		scopus, plos, researchblogging, biod, webofscience, pmc, facebook,
#' 		mendeley, twitter, wikipedia, and scienceseeker.
#' 		
#' 		Beware that some data source are not parsed yet, so there may be event data
#' 		but it is not provided yet as it is so messy to parse. 
#' @return PLoS altmetrics as data.frame's.
#' @examples \dontrun{
#' # For one article
#' out <- almevents(doi="10.1371/journal.pone.0029797")
#' out[["pmc"]] # get the results for PubMed Central
#' out[["twitter"]] # get the results for twitter (boo, there aren't any)
#' out[c("scienceseeker","crossref")] # get the results for two sources
#' 
#' # two doi's
#' dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117')
#' almevents(doi=dois)
#' }
#' @export
almevents <- function(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL, 
	months = NULL, days = NULL, key = NULL, 
	url = 'http://alm.plos.org/api/v3/articles', curl = getCurlHandle())
{
	id <- compact(list(doi=doi, pmid=pmid, pmcid=pmcid, mendeley=mdid))
	if(length(id)>1){ stop("Only supply one of: doi, pmid, pmcid, mdid") } else { NULL }
	key <- getkey(key)
	
	doit <- function() {	
		args <- compact(list(api_key = key, info = 'detail', months = months, 
												 days = days, type = names(id)))
		if(length(id[[1]])==0){stop("Please provide a DOI")} else
			if(length(id[[1]])==1){
				if(names(id) == "doi") id <- gsub("/", "%2F", id)
				args2 <- c(args, ids = id[[1]])
				out <- getForm(url, .params = args2, curl = curl)
				ttt <- fromJSON(out)
			} else
				if(length(id[[1]])>1){
					if(length(id[[1]])>30){
						slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
						idsplit <- slice(id[[1]], 30)
						repeatit <- function(y) {
							if(names(id) == "doi"){ 
								id2 <- paste(sapply(y, function(x) gsub("/", "%2F", x)), collapse=",")
							} else
							{
								id2 <- paste(id[[1]], collapse=",")
							}
							args2 <- c(args, ids = id2)
							out <- getForm(url, .params = args2, curl = curl)
							ttt <- fromJSON(out)
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
						ttt <- fromJSON(out)
					}
				}
		
		events <- lapply(ttt, function(x) x$article$sources)
	
		getevents <- function(x){
			bbb <- function(y){
				if(y$source$name == "counter"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
					{
						months <- as.numeric(sapply(y$source$events, `[[`, "month"))
						pdf_views <- as.numeric(sapply(y$source$events, `[[`, "pdf_views"))
						html_views <- as.numeric(sapply(y$source$events, `[[`, "html_views"))
						xml_views <- as.numeric(sapply(y$source$events, `[[`, "xml_views"))
						data.frame(months, pdf_views, html_views, xml_views)
					}
				} else if(y$source$name == "citeulike"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
					{
						temp <- t(data.frame(unlist(y$source$events)))
						row.names(temp) <- NULL
						temp
					}
				} else if(y$source$name == "crossref"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
					{			
						myy <- function(x) {
							if(length(x[[1]]$contributors$contributor[[1]])>1){
								x[[1]]$contributors$contributor <-
									paste(sapply(x[[1]]$contributors$contributor,
															 function(x) paste(x[2:3], collapse=", ")), collapse="; ")
								x[[1]]$issn <- paste(x[[1]]$issn, collapse="; ")
								data.frame(x[[1]])
							} else {
								x[[1]]$contributors$contributor <-
									paste(x[[1]]$contributors$contributor[2:3], collapse=", ")
								x[[1]]$issn <- paste(x[[1]]$issn, collapse="; ")
								data.frame(x[[1]])
							}
						}
						ldply(y$source$events, myy)
					}
				}
				else if(y$source$name == "nature"){
					paste("sorry, no events content yet")
				} else if(y$source$name == "researchblogging"){
					paste("sorry, no events content yet")
				} else if(y$source$name == "biod"){
					paste("sorry, no events content yet")
				} else if(y$source$name == "pubmed"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
						{ sapply(y$source$events, `[[`, "event") }
				} else if(y$source$name == "facebook"){
					paste("sorry, no events content yet")
				} else if(y$source$name == "mendeley"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
						{ y$source$events }
				} else if(y$source$name == "twitter"){
					paste("sorry, no events content yet")
				} else if(y$source$name == "wikipedia"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
						{ ldply(y$source$events, function(x) as.data.frame(x)) }
				} else if(y$source$name == "bloglines"){
					paste("sorry, no events content yet")
				} else if(y$source$name == "postgenomic"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
						{
							temp <- y$source$events[[1]]
							name <- temp$event$blog_name
							dois <- sapply(temp$event$citing, function(x) x$doi_id )
							data.frame(name, dois)
						}
				} else if(y$source$name == "scopus"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
						{ y$source$events[[1]] }
				} else if(y$source$name == "wos"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
						{ y$source$events[[1]] }
				} else if(y$source$name == "pmc"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
					{
						nnn <- function(x, names_){
							gg <- data.frame(x)
							gg$it <- row.names(gg)
							if(!names_){as.numeric(as.character(t(sort_df(gg, "it")[,-2])))} else
							{ sort_df(gg, "it")[,-1] }
						}
						df <- ldply(y$source$events, nnn, names_=FALSE)
						names(df) <- nnn(y$source$events[[1]], TRUE)
						df
					}
				} else if(y$source$name == "connotea"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
					{ paste("implement parsing this dumbo") }
				} else if(y$source$name == "scienceseeker"){
					if(length(y$source$events)==0){paste("sorry, no events content yet")} else
					{ paste("implement parsing this dumbo") }
				}
			}
			lapply(x, bbb)
		}
		temp <- lapply(events, getevents)
		names(temp[[1]]) <- c("bloglines","citeulike","connotea","crossref","nature",
										"postgenomic","pubmed","scopus","plos","researchblogging",
										"biod","webofscience","pmc","facebook","mendeley","twitter",
										"wikipedia","scienceseeker")
		temp[[1]]
	}
	safe_doit <- plyr::failwith(NULL,doit)
	safe_doit()
}