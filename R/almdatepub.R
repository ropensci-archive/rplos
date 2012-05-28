#' Get the date when the article was published.
#' @import RJSONIO RCurl
#' @param doi Digital object identifier for an article in PLoS Journals
#' @param get Get year, month, or day; if unspecified, whole date returned.
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls.
#' @param key your PLoS API key, either enter, or loads from .Rprofile
#' @param url the PLoS API url for the function (should be left to default)
#' @param ... optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @return Date when article was published.
#' @export
#' @examples 
#' almdatepub('10.1371/journal.pone.0026871')
#' almdatepub('10.1371/journal.pone.0026871', 'year')
#'
#' # DOI that does not work, gives NA so that looping isn't interrupted
#' # almdatepub(doi="10.1371/journal.pone.002699", get='year')
almdatepub <-

function(doi, get = NA, sleep = 0,
  url = 'http://alm.plos.org/articles',
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
  ...,
  curl = getCurlHandle() ) {

  Sys.sleep(sleep)
  url2 <- paste(url, "/", doi, '.json?api_key=', key, sep='')
#   tt <- getURLContent(url2)
  if(class(try(fromJSON(I(getURLContent(url2)))$article$published,
          silent = T ) ) %in% 'try-error')
      { dateout <- NA } else
        { date <- fromJSON(I(getURLContent(url2)))$article$published
          date_vector <- str_split(str_split(date, "T")[[1]][1], "-")[[1]]
          if(is.na(get) == TRUE) {dateout <- str_split(date, "T")[[1]][1]} else
            if(get == 'year') {dateout <- as.numeric(date_vector[1])} else
              if(get == 'month') {dateout <- as.numeric(date_vector[2])} else
                if(get == 'day') {dateout <- as.numeric(date_vector[3])}
        }
#   date <- fromJSON(I(getURLContent(url2)))$article$published
  dateout
}
