#' Base function to search PLoS Journals
#' 
#' @import RCurl httr
#' @importFrom stringr str_extract
#' @importFrom lubridate now
#' @importFrom RJSONIO fromJSON
#' @template high
#' @return A list.
#' @examples \dontrun{
#' highplos(q='alcohol', hl.fl = 'abstract', limit=10)
#' highplos(q='alcohol', hl.fl = 'abstract', limit=1200)
#' }
#' @export

highplos <- function(q, hl.fl = NULL, hl.snippets = NULL, hl.fragsize = NULL,
  hl.q = NULL, hl.mergeContiguous = NULL, hl.requireFieldMatch = NULL, 
  hl.maxAnalyzedChars = NULL, hl.alternateField = NULL, hl.maxAlternateFieldLength = NULL, 
  hl.preserveMulti = NULL, hl.maxMultiValuedToExamine = NULL, 
  hl.maxMultiValuedToMatch = NULL, hl.formatter = NULL, hl.simple.pre = NULL, 
  hl.simple.post = NULL, hl.fragmenter = NULL, hl.fragListBuilder = NULL, 
  hl.fragmentsBuilder = NULL, hl.boundaryScanner = NULL, hl.bs.maxScan = NULL, 
  hl.bs.chars = NULL, hl.bs.type = NULL, hl.bs.language = NULL, hl.bs.country = NULL, 
  hl.useFastVectorHighlighter = NULL, hl.usePhraseHighlighter = NULL, 
  hl.highlightMultiTerm = NULL, hl.regex.slop = NULL, hl.regex.pattern = NULL, 
  hl.regex.maxAnalyzedChars = NULL, start = 0, limit = NA, 
  key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")), 
  sleep = 6, callopts=list())
{
  # Enforce rate limits
  if(!Sys.getenv('plostime') == ""){
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if(timesince < 6){
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }
  
  url = 'http://api.plos.org/search'
  
  args <- compact(list(wt="json", q=q, start=start, rows=limit, hl='true', hl.fl=hl.fl,
     hl.snippets=hl.snippets, hl.fragsize=hl.fragsize, fl='DOES_NOT_EXIST', 
     hl.mergeContiguous = hl.mergeContiguous, hl.requireFieldMatch = hl.requireFieldMatch, 
     hl.maxAnalyzedChars = hl.maxAnalyzedChars, hl.alternateField = hl.alternateField, 
     hl.maxAlternateFieldLength = hl.maxAlternateFieldLength, hl.preserveMulti = hl.preserveMulti, 
     hl.maxMultiValuedToExamine = hl.maxMultiValuedToExamine, hl.maxMultiValuedToMatch = hl.maxMultiValuedToMatch, 
     hl.formatter = hl.formatter, hl.simple.pre = hl.simple.pre, hl.simple.post = hl.simple.post, 
     hl.fragmenter = hl.fragmenter, hl.fragListBuilder = hl.fragListBuilder, hl.fragmentsBuilder = hl.fragmentsBuilder, 
     hl.boundaryScanner = hl.boundaryScanner, hl.bs.maxScan = hl.bs.maxScan, hl.bs.chars = hl.bs.chars, 
     hl.bs.type = hl.bs.type, hl.bs.language = hl.bs.language, hl.bs.country = hl.bs.country, 
     hl.useFastVectorHighlighter = hl.useFastVectorHighlighter, hl.usePhraseHighlighter = hl.usePhraseHighlighter, 
     hl.highlightMultiTerm = hl.highlightMultiTerm, hl.regex.slop = hl.regex.slop, hl.regex.pattern = hl.regex.pattern, 
     hl.regex.maxAnalyzedChars = hl.regex.maxAnalyzedChars))
  
  argsgetnum <- list(q=q, rows=0, wt="json", api_key=key)
  getnum <- getForm(url, .params = argsgetnum, curl = curl, .encoding=)
  getnumrecords <- fromJSON(I(getnum))$response$numFound
  if(getnumrecords > limit){getnumrecords <- limit} else{getnumrecords <- getnumrecords}
  
  if(min(getnumrecords, limit) < 1000) {
    if(!is.na(limit))
      args$rows <- limit
    tt <- GET(url, query = args, callopts)
    stop_for_status(tt)
    return( content(tt)$highlighting )
  } else
  { 
    byby <- 500
    getvecs <- seq(from=1, to=getnumrecords, by=byby)
    lastnum <- as.numeric(str_extract(getnumrecords, "[0-9]{3}$"))
    if(lastnum==0)
      lastnum <- byby
    if(lastnum > byby){
      lastnum <- getnumrecords-getvecs[length(getvecs)]
    } else 
    {lastnum <- lastnum}
    getrows <- c(rep(byby, length(getvecs)-1), lastnum)
    out <- list()
    message("Looping - printing iterations...")
    for(i in 1:length(getvecs)) {
      cat(i,"\n")
      args$start <- getvecs[i]
      args$rows <- getrows[i]
      tt <- GET(url, query=args, callopts)
      stop_for_status(tt)
      out[[i]] <- content(tt)$highlighting
    }
    return( do.call(c, out) )
  }
  Sys.setenv(plostime = as.numeric(now()))
}