#' Get the date when the article was published.
#' 
#' @import RJSONIO RCurl
#' @param doi Digital object identifier for an article in PLoS Journals
#' @param get Get year, month, or day; if unspecified, whole date returned.
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @return Date when article was published.
#' @examples \dontrun{
#' almdatepub(doi='10.1371/journal.pone.0026871')
#' almdatepub('10.1371/journal.pone.0026871', 'year')
#' 
#' # Provide more than one DOI
#' dois <- c('10.1371/journal.pone.0026871','10.1371/journal.pone.0048868',
#' 		'10.1371/journal.pone.0048705','10.1371/journal.pone.0048731')
#' almdatepub(doi=dois, get="month")
#' }
#' @examples \donttest{
#' #' # DOI that does not work, gives NA so that looping isn't interrupted
#' almdatepub(doi="10.1371/journal.pone.002699", get='year')
#' }
#' @export
almdatepub <- function(doi, get = NA, sleep = 0, key = NULL)
{
	url = 'http://alm.plos.org/api/v3/articles'
	
	getdate <- function(x) {
		date <- x$publication_date
		date_vector <- str_split(str_split(date, "T")[[1]][1], "-")[[1]]
		if(is.na(get) == TRUE) {dateout <- str_split(date, "T")[[1]][1]} else
			if(get == 'year') {dateout <- as.numeric(date_vector[1])} else
				if(get == 'month') {dateout <- as.numeric(date_vector[2])} else
					if(get == 'day') {dateout <- as.numeric(date_vector[3])}
		dateout
	}
	
  Sys.sleep(sleep)
  key <- getkey(key)
  if(length(doi)==0){stop("Please provide a DOI")} else
	  if(length(doi)==1){
	  	doi <- paste("doi/", doi, sep="")
	  	doi2 <- gsub("/", "%2F", doi)
	  	url2 <- paste(url, "/info%3A", doi2, '?api_key=', key, sep='')
	  	date <- fromJSON(url2)
	  	getdate(date[[1]])
	  } else
	  	if(length(doi)>1){
	  		doi2 <- paste(sapply(doi, function(x) gsub("/", "%2F", x)), collapse=",")
	  		url2 <- paste(url, "?ids=", doi2, sep="")
	  		out <- fromJSON(url2)
	  		sapply(out, getdate)
	  	}
}