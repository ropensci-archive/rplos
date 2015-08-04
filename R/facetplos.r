#' Do faceted searches on PLOS Journals full-text content
#'
#' @export
#' @return A list
#' @template facet
#' @examples \dontrun{
#' # Facet on a single field
#' facetplos(q='*:*', facet.field='journal')
#' facetplos(q='alcohol', facet.field='article_type')
#'
#' # Facet on multiple fields
#' facetplos(q='alcohol', facet.field=c('journal','subject'))
#'
#' # Using mincount
#' facetplos(q='alcohol', facet.field='journal', facet.mincount='500')
#'
#' # Using facet.query to get counts
#' ## A single facet.query term
#' facetplos(q='*:*', facet.field='journal', facet.query='cell')
#' ## Many facet.query terms
#' facetplos(q='*:*', facet.field='journal', facet.query='cell,bird')
#'
#' # Date faceting
#' facetplos(q='*:*', facet.date='publication_date',
#'  facet.date.start='NOW/DAY-5DAYS', facet.date.end='NOW', facet.date.gap='+1DAY')
#'
#' # Range faceting
#' facetplos(q='*:*', url=url, facet.range='counter_total_all',
#'  facet.range.start=5, facet.range.end=1000, facet.range.gap=10)
#' facetplos(q='alcohol', facet.range='alm_facebookCount', facet.range.start=1000,
#'    facet.range.end=5000, facet.range.gap = 100)
#'
#' # Range faceting with > 1 field, same settings
#' facetplos(q='*:*', url=url, facet.range=c('counter_total_all','alm_twitterCount'),
#'  facet.range.start=5, facet.range.end=1000, facet.range.gap=10)
#'
#' # Range faceting with > 1 field, different settings
#' facetplos(q='*:*', url=url, facet.range=c('counter_total_all','alm_twitterCount'),
#'  f.counter_total_all.facet.range.start=5, f.counter_total_all.facet.range.end=1000,
#'  f.counter_total_all.facet.range.gap=10, f.alm_twitterCount.facet.range.start=5,
#'  f.alm_twitterCount.facet.range.end=1000, f.alm_twitterCount.facet.range.gap=10)
#' }

facetplos <- function(q="*:*", facet.query=NA, facet.field=NA,
  facet.prefix=NA,facet.sort=NA,facet.limit=NA,facet.offset=NA,
  facet.mincount=NA,facet.missing=NA,facet.method=NA,facet.enum.cache.minDf=NA,
  facet.threads=NA,facet.date=NA,facet.date.start=NA,facet.date.end=NA,
  facet.date.gap=NA,facet.date.hardend=NA,facet.date.other=NA,
  facet.date.include=NA,facet.range=NA,facet.range.start=NA,facet.range.end=NA,
  facet.range.gap=NA,facet.range.hardend=NA,facet.range.other=NA,
  facet.range.include=NA, start=NA, rows=NA, url=NA, sleep = 6, callopts=list(), ...)
{
  # Enforce rate limits
  if (!Sys.getenv('plostime') == "") {
    timesince <- as.numeric(now()) - as.numeric(Sys.getenv('plostime'))
    if (timesince < 6) {
      stopifnot(is.numeric(sleep))
      Sys.sleep(sleep)
    }
  }

  out <- solr_facet(facet.query=facet.query,facet.field=facet.field,
    facet.prefix=facet.prefix,facet.sort=facet.sort,facet.limit=facet.limit,
    facet.offset=facet.offset,facet.mincount=facet.mincount,facet.missing=facet.missing,
    facet.method=facet.method,facet.enum.cache.minDf=facet.enum.cache.minDf,
    facet.threads=facet.threads,facet.date=facet.date,facet.date.start=facet.date.start,
    facet.date.end=facet.date.end,facet.date.gap=facet.date.gap,
    facet.date.hardend=facet.date.hardend,facet.date.other=facet.date.other,
    facet.date.include=facet.date.include,facet.range=facet.range,
    facet.range.start=facet.range.start,facet.range.end=facet.range.end,
    facet.range.gap=facet.range.gap,facet.range.hardend=facet.range.hardend,
    facet.range.other=facet.range.other,facet.range.include=facet.range.include,
    start=start, rows=rows, base=pbase(), callopts=callopts, ...)

  return( out )

  Sys.setenv(plostime = as.numeric(now()))
}
