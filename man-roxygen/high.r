#' @param q Search terms (character). You can search on specific fields by 
#'    doing 'field:your query'. For example, a real query on a specific field would 
#'    be 'author:Smith'.
#' @param hl XXXX
#' @param hl.q XXXX
#' @param hl.fl XXXX
#' @param hl.snippets XXXX
#' @param hl.fragsize XXXX
#' @param hl.mergeContiguous XXXX
#' @param hl.requireFieldMatch XXXX
#' @param hl.maxAnalyzedChars XXXX
#' @param hl.alternateField XXXX
#' @param hl.maxAlternateFieldLength XXXX
#' @param hl.preserveMulti XXXX
#' @param hl.maxMultiValuedToExamine XXXX
#' @param hl.maxMultiValuedToMatch XXXX
#' @param hl.formatter XXXX
#' @param hl.simple.pre XXXX
#' @param hl.simple.post XXXX
#' @param hl.fragmenter XXXX
#' @param hl.fragListBuilder XXXX
#' @param hl.fragmentsBuilder XXXX
#' @param hl.boundaryScanner XXXX
#' @param hl.bs.maxScan XXXX
#' @param hl.bs.chars XXXX
#' @param hl.bs.type XXXX
#' @param hl.bs.language XXXX
#' @param hl.bs.country XXXX
#' @param hl.useFastVectorHighlighter XXXX
#' @param hl.usePhraseHighlighter XXXX
#' @param hl.highlightMultiTerm XXXX
#' @param hl.regex.slop XXXX
#' @param hl.regex.pattern XXXX
#' @param hl.regex.maxAnalyzedChars XXXX
#' @param start Record to start at (used in combination with limit when 
#'    you need to cycle through more results than the max allowed=1000)
#' @param limit Number of results to return (integer)
#' @param key Your PLoS API key, either enter as the key, or loads from .Rprofile. 
#'    See details.
#' @param sleep Number of seconds to wait between requests. No need to use this for
#'    a single call to searchplos. However, if you are using searchplos in a loop or 
#'    lapply type call, do sleep parameter is used to prevent your IP address from being 
#'    blocked. You can only do 10 requests per minute, so one request every 6 seconds is 
#'    about right.
#' @param callopts Optional additional curl options (debugging tools mostly)