#' Base function to search PLoS Journals
#'
#' @export
#' @template plos
#' @return An object of class "plos", with a list of length two, each
#' element being a list itself.
#' @examples \dontrun{
#' searchplos(q='ecology', fl=c('id','publication_date'), limit = 2)
#' searchplos('ecology', fl=c('id','publication_date'), limit = 2)
#' searchplos('ecology', c('id','title'), limit = 2)
#'
#' # Get only full article DOIs
#' out <- searchplos(q="*:*", fl='id', fq='doc_type:full', start=0, limit=250)
#' head(out$data)
#'
#' # Get DOIs for only PLoS One articles
#' out <- searchplos(q="*:*", fl='id', fq='journal_key:PLoSONE', start=0, limit=15)
#' out$data
#'
#' # Get DOIs for full article in PLoS One
#' out <- searchplos(q="*:*", fl='id', fq=list('journal_key:PLoSONE',
#'    'doc_type:full'), limit=50)
#' out$data
#'
#' # Serch for many q
#' q <- c('ecology','evolution','science')
#' lapply(q, function(x) searchplos(x, limit=2))
#'
#' # Query to get some PLOS article-level metrics, notice difference between two outputs
#' out <- searchplos(q="*:*", fl=c('id','counter_total_all','alm_twitterCount'),fq='doc_type:full')
#' out_sorted <- searchplos(q="*:*", fl=c('id','counter_total_all','alm_twitterCount'),
#'    fq='doc_type:full', sort='counter_total_all desc')
#' out$data
#' out_sorted$data
#'
#' # Show me all articles that have these two words less then about 15 words apart.
#' searchplos(q='everything:"sports alcohol"~15', fl='title', fq='doc_type:full')
#'
#' # Now let's try to narrow our results to 7 words apart. Here I'm changing the ~15 to ~7
#' searchplos(q='everything:"sports alcohol"~7', fl='title', fq='doc_type:full')
#'
#' # A list of articles about social networks that are popular on a social network
#' searchplos(q="*:*",fl=c('id','alm_twitterCount'),
#'    fq=list('doc_type:full','subject:"Social networks"','alm_twitterCount:[100 TO 10000]'),
#'    sort='counter_total_month desc')
#'
#' # Now, lets also only look at articles that have seen some activity on twitter.
#' # Add "fq=alm_twitterCount:[1 TO *]" as a parameter within the fq argument.
#' searchplos(q='everything:"sports alcohol"~7', fl=c('alm_twitterCount','title'),
#'    fq=list('doc_type:full','alm_twitterCount:[1 TO *]'))
#' searchplos(q='everything:"sports alcohol"~7', fl=c('alm_twitterCount','title'),
#'    fq=list('doc_type:full','alm_twitterCount:[1 TO *]'),
#'    sort='counter_total_month desc')
#'
#' # Return partial doc parts
#' ## Return Abstracts only
#' out <- searchplos(q='*:*', fl=c('doc_partial_body','doc_partial_parent_id'),
#'    fq=list('doc_type:partial', 'doc_partial_type:Abstract'), limit=3)
#' ## Return Title's only
#' out <- searchplos(q='*:*', fl=c('doc_partial_body','doc_partial_parent_id'),
#'    fq=list('doc_type:partial', 'doc_partial_type:Title'), limit=3)
#'
#' # Remove DOIs for annotations (i.e., corrections)
#' searchplos(q='*:*', fl=c('id','article_type'),
#'    fq='-article_type:correction', limit=100)
#'
#' # Remove DOIs for annotations (i.e., corrections) and Viewpoints articles
#' searchplos(q='*:*', fl=c('id','article_type'),
#'    fq=list('-article_type:correction','-article_type:viewpoints'), limit=100)
#'
#' # Get eissn codes
#' searchplos(q='*:*', fl=c('id','journal','eissn','cross_published_journal_eissn'),
#'    fq="doc_type:full", limit = 60)
#'
#' searchplos(q='*:*', fl=c('id','journal','eissn','cross_published_journal_eissn'),
#'    limit = 2000)
#' }

searchplos <- function(q = NULL, fl = 'id', fq = NULL, sort = NULL, start = 0,
  limit = 10, sleep = 6, errors = "simple", proxy = NULL, callopts = list(), ...) {

  # Make sure limit is a numeric or integer
  limit <- tryCatch(as.numeric(as.character(limit)), warning=function(e) e)
  if("warning" %in% class(limit)){
    stop("limit should be a numeric or integer class value", call. = FALSE)
  }
  if(!inherits(limit, "numeric") | is.na(limit))
    stop("limit should be a numeric or integer class value", call. = FALSE)

  # Enforce rate limits
  if(!Sys.getenv('plostime') == ""){
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if(timesince < 6){
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }

  if (is.null(limit)) limit <- 999
  if (limit == 0) fl <- NULL
  fl <- paste(fl, collapse = ",")

  args <- list()
 	if (!is.null(fq[[1]])) {
  	if (length(fq) == 1) {
  		args$fq <- fq
  	} else {
    	args <- fq
    	names(args) <- rep("fq",length(args))
  	}
  }
  args <- c(args, ploscompact(list(q = q, fl = fl, start = start,
                       rows = limit, sort = sort, wt = 'json')))

	getnum_tmp <- suppressMessages(
	  conn_plos$search(params = list(q = q, fl = fl, rows = 0, wt = "json"))
	)
	getnumrecords <- attr(getnum_tmp, "numFound")

	if (getnumrecords > limit) {
	  getnumrecords <- limit
	} else {
	  getnumrecords <- getnumrecords
	}

	if (min(getnumrecords, limit) < 1000) {
	  if (!is.null(limit)) args$rows <- limit
	  if (length(args) == 0) args <- NULL
	  jsonout <- suppressMessages(
	    conn_plos$search(params = args, callopts = callopts,
	    	minOptimizedRows = FALSE, ...)
	  )
	  meta <- dplyr::data_frame(
	    numFound = attr(jsonout, "numFound"),
	    start = attr(jsonout, "start")
	  )
    return(list(meta = meta, data = jsonout))
	} else {
	  byby <- 500
	  getvecs <- seq(from = 0, to = getnumrecords - 1, by = byby)
	  lastnum <- as.numeric(strextract(getnumrecords, "[0-9]{3}$"))
	  if (lastnum == 0)
	    lastnum <- byby
	  if (lastnum > byby) {
	    lastnum <- getnumrecords - getvecs[length(getvecs)]
	  } else {
	    lastnum <- lastnum
	  }
	  getrows <- c(rep(byby, length(getvecs) - 1), lastnum)
	  out <- list()
	  message("Looping - printing progress ...")
	  for (i in seq_along(getvecs)) {
	    args$start <- getvecs[i]
	    args$rows <- getrows[i]
	    if (length(args) == 0) args <- NULL
	    jsonout <- suppressMessages(conn_plos$search(
	      params = ploscompact(list(q = args$q, fl = args$fl, 
        fq = args[names(args) == "fq"],
        # fq = args$fq,
	      sort = args$sort,
	      rows = args$rows, start = args$start,
	      wt = "json")), minOptimizedRows = FALSE, callopts = callopts, ...
	    ))
	    out[[i]] <- jsonout
	  }
	  resdf  <- dplyr::bind_rows(out)
	  meta <- dplyr::data_frame(
	    numFound = attr(jsonout, "numFound"),
	    start = attr(jsonout, "start")
	  )
	  return(list(meta = meta, data = resdf))
	}
  Sys.setenv(plostime = as.numeric(now()))
}

# Function to trim leading and trailing whitespace, including newlines
trim <- function(x) gsub("\\n\\s+", " ", gsub("^\\s+|\\s+$", "", x))
