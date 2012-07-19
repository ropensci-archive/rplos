\name{searchplos}
\alias{searchplos}
\title{Base function to search PLoS Journals}
\usage{
  searchplos(terms = NA, fields = NA, toquery = NA,
    start = 1, limit = NA, returndf = TRUE,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())

  searchplos(terms = NA, fields = NA, toquery = NA,
    start = 1, limit = NA, returndf = TRUE,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())

  searchplos(terms = NA, fields = NA, toquery = NA,
    start = 1, limit = NA, returndf = TRUE,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())

  searchplos(terms = NA, fields = NA, toquery = NA,
    start = 1, limit = NA, returndf = TRUE,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields
  [type 'data(plosfields)', then 'plosfields']}

  \item{toquery}{list specific fields to query (if NA, all
  queried)}

  \item{start}{record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{terms}{Search terms (character)}

  \item{fields}{Fields to return from search (character)
  (e.g., c('id','title')), any combination of search fields
  (type 'data(plosfields)', then 'plosfields').}

  \item{toquery}{List specific fields to query (if NA, all
  queried).}

  \item{start}{record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{terms}{Search terms (character)}

  \item{fields}{Fields to return from search (character)
  (e.g., c('id','title')), any combination of search fields
  (type 'data(plosfields)', then 'plosfields').}

  \item{toquery}{List specific fields to query (if NA, all
  queried).}

  \item{start}{record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{parallel}{Parallelize when more than 999 results?
  Default = FALSE.}

  \item{cores}{Number of CPU cores to use, only set if
  parallel = TRUE.}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}

  \item{terms}{Search terms (character)}

  \item{fields}{Fields to return from search (character)
  (e.g., c('id','title')), any combination of search fields
  (type 'data(plosfields)', then 'plosfields').}

  \item{toquery}{List specific fields to query (if NA, all
  queried).}

  \item{start}{record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  Number of search results (vis = FALSE), or number of
  search in a table and a histogram of results (vis =
  TRUE).

  Number of search results (vis = FALSE), or number of
  search in a table and a histogram of results (vis =
  TRUE).

  Number of search results (vis = FALSE), or number of
  search in a table and a histogram of results (vis =
  TRUE).

  Number of search results (vis = FALSE), or number of
  search in a table and a histogram of results (vis =
  TRUE).
}
\description{
  Base function to search PLoS Journals

  Base function to hit the PLoS Journals Search API.

  Base function to hit the PLoS Journals Search API.

  Base function to hit the PLoS Journals Search API.
}
\examples{
\dontrun{
searchplos(terms='ecology', fields='id', limit = 1200)
searchplos('ecology', 'id,publication_date', limit = 2)
searchplos('ecology', 'id,title', limit = 2)
searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery='cross_published_journal_key:PLoSONE', start=0, limit=250)
searchplos(terms="*:*", fields='id',
   toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'),
   start=0, limit=250)
}
\dontrun{
mydat <- searchplos(terms='science', fields=c('id','journal','volume','pagecount','editor'), returndf = T)
searchplos(terms='ecology', fields='id')
searchplos(terms='ecology', fields=c('id','publication_date'), limit = 2)
searchplos('ecology', 'id', limit = 100)
searchplos('ecology', c('id','title'), limit = 2)
searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery='cross_published_journal_key:PLoSONE', start=0, limit=250)
searchplos(terms="*:*", fields='id',
   toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'),
   start=0, limit=250)
}
\dontrun{
mydat <- searchplos(terms='science', fields=c('id','journal','volume','pagecount','editor'), returndf = T)
searchplos(terms='ecology', fields=c('id','publication_date'), limit = 2, returndf = TRUE)
searchplos(terms='ecology', fields='id', limit = 100)
searchplos('ecology', c('id','title'), limit = 2)
searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery='cross_published_journal_key:PLoSONE', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), start=0, limit=250)
}
\dontrun{
mydat <- searchplos(terms='science', fields=c('id','journal','volume','pagecount','editor'), returndf = T)
mydat[[2]] # return just the data
searchplos(terms='ecology', fields=c('id','publication_date'), limit = 2, returndf = TRUE)
searchplos(terms='ecology', fields='id', limit = 100)
searchplos(terms='ecology', fields=c('id','title','author','pagecount'), limit = 200, returndf=F)
searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery='cross_published_journal_key:PLoSONE', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), start=0, limit=250)
}
}

