#' Do highlighted searches on PLOS Journals full-text content
#'
#' @export
#' @template high
#' @return A list.
#' @examples \dontrun{
#' highplos(q='alcohol', hl.fl = 'abstract', rows=10)
#' highplos(q='alcohol', hl.fl = c('abstract','title'), rows=10)
#' highplos(q='everything:"sports alcohol"~7', hl.fl='everything')
#' highplos(q='alcohol', hl.fl='abstract', hl.fragsize=20, rows=5)
#' highplos(q='alcohol', hl.fl='abstract', hl.snippets=5, rows=5)
#' highplos(q='alcohol', hl.fl='abstract', hl.snippets=5, hl.mergeContiguous='true', rows=5)
#' highplos(q='alcohol', hl.fl='abstract', hl.useFastVectorHighlighter='true', rows=5)
#' highplos(q='everything:"experiment"', fq='doc_type:full', rows=100, hl.fl = 'title')
#' }
#'
#' @examples \donttest{
#' highplos(q='alcohol', hl.fl = 'abstract', rows=1200)
#' }

highplos <- function(q, fl=NULL, fq=NULL, hl.fl = NULL, hl.snippets = NULL, hl.fragsize = NULL,
   hl.q = NULL, hl.mergeContiguous = NULL, hl.requireFieldMatch = NULL,
   hl.maxAnalyzedChars = NULL, hl.alternateField = NULL, hl.maxAlternateFieldLength = NULL,
   hl.preserveMulti = NULL, hl.maxMultiValuedToExamine = NULL,
   hl.maxMultiValuedToMatch = NULL, hl.formatter = NULL, hl.simple.pre = NULL,
   hl.simple.post = NULL, hl.fragmenter = NULL, hl.fragListBuilder = NULL,
   hl.fragmentsBuilder = NULL, hl.boundaryScanner = NULL, hl.bs.maxScan = NULL,
   hl.bs.chars = NULL, hl.bs.type = NULL, hl.bs.language = NULL, hl.bs.country = NULL,
   hl.useFastVectorHighlighter = NULL, hl.usePhraseHighlighter = NULL,
   hl.highlightMultiTerm = NULL, hl.regex.slop = NULL, hl.regex.pattern = NULL,
   hl.regex.maxAnalyzedChars = NULL, start = 0, rows = NULL,
   callopts=list(), sleep=6, ...)
{
  if(!Sys.getenv('plostime') == ""){
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if(timesince < 6){
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }

  if(!is.null(fl)) fl <- paste(fl, collapse = ",")
  out <- solr_highlight(base=pbase(), q=q, fl=fl, fq=fq, wt='json', start=start, rows=rows, hl.fl=hl.fl,
    hl.snippets=hl.snippets, hl.fragsize=hl.fragsize,
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
    hl.regex.maxAnalyzedChars = hl.regex.maxAnalyzedChars, ...)
  return( out )
  Sys.setenv(plostime=as.numeric(now()))
}
