\name{facetplos}
\alias{facetplos}
\title{Faceted search of PLOS articles}
\usage{
facetplos(q = "*:*", facet.query = NA, facet.field = NA,
  facet.prefix = NA, facet.sort = NA, facet.limit = NA,
  facet.offset = NA, facet.mincount = NA, facet.missing = NA,
  facet.method = NA, facet.enum.cache.minDf = NA, facet.threads = NA,
  facet.date = NA, facet.date.start = NA, facet.date.end = NA,
  facet.date.gap = NA, facet.date.hardend = NA, facet.date.other = NA,
  facet.date.include = NA, facet.range = NA, facet.range.start = NA,
  facet.range.end = NA, facet.range.gap = NA, facet.range.hardend = NA,
  facet.range.other = NA, facet.range.include = NA, start = NA,
  rows = NA, key = NULL, url = NA, callopts = list(), ...)
}
\arguments{
  \item{facet}{XXXX}

  \item{facet.query}{XXXX}

  \item{facet.field}{XXXX}

  \item{facet.prefix}{XXXX}

  \item{facet.sort}{XXXX}

  \item{facet.limit}{XXXX}

  \item{facet.offset}{XXXX}

  \item{facet.mincount}{XXXX}

  \item{facet.missing}{XXXX}

  \item{facet.method}{XXXX}

  \item{facet.enum.cache.minDf}{XXXX}

  \item{facet.threads}{XXXX}

  \item{facet.date}{XXXX}

  \item{facet.date.start}{XXXX}

  \item{facet.date.end}{XXXX}

  \item{facet.date.gap}{XXXX}

  \item{facet.date.hardend}{XXXX}

  \item{facet.date.other}{XXXX}

  \item{facet.date.include}{XXXX}

  \item{facet.range}{XXXX}

  \item{facet.range.start}{XXXX}

  \item{facet.range.end}{XXXX}

  \item{facet.range.gap}{XXXX}

  \item{facet.range.hardend}{XXXX}

  \item{facet.range.other}{XXXX}

  \item{facet.range.include}{XXXX}

  \item{q}{Query terms}

  \item{start}{Record to start at, default to beginning.}

  \item{rows}{Number of records to return.}

  \item{key}{API key, if needed.}

  \item{url}{URL endpoint}

  \item{callopts}{Call options passed on to httr::GET}

  \item{...}{Further args.}
}
\value{
A list
}
\description{
Faceted search of PLOS articles
}
\examples{
\dontrun{
# Facet on a single field
facetplos(q='*:*', facet.field='journal')

# Facet on multiple fields
facetplos(q='alcohol', facet.field='journal,subject')

# Using mincount
facetplos(q='alcohol', facet.field='journal', facet.mincount='500')

# Using facet.query to get counts
## A single facet.query term
facetplos(q='*:*', facet.field='journal', facet.query='cell')
## Many facet.query terms
facetplos(q='*:*', facet.field='journal', facet.query='cell,bird')

# Date faceting
facetplos(q='*:*', url=url, facet.date='publication_date',
 facet.date.start='NOW/DAY-5DAYS', facet.date.end='NOW', facet.date.gap='+1DAY')

# Range faceting
facetplos(q='*:*', url=url, facet.range='counter_total_all',
 facet.range.start=5, facet.range.end=1000, facet.range.gap=10)

# Range faceting with > 1 field, same settings
facetplos(q='*:*', url=url, facet.range='counter_total_all,alm_twitterCount',
 facet.range.start=5, facet.range.end=1000, facet.range.gap=10)

# Range faceting with > 1 field, different settings
facetplos(q='*:*', url=url, facet.range='counter_total_all,alm_twitterCount',
 f.counter_total_all.facet.range.start=5, f.counter_total_all.facet.range.end=1000,
 f.counter_total_all.facet.range.gap=10, f.alm_twitterCount.facet.range.start=5, f.alm_twitterCount.facet.range.end=1000,
 f.alm_twitterCount.facet.range.gap=10)
}
}

