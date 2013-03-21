\name{searchplos}
\alias{searchplos}
\title{Base function to search PLoS Journals}
\usage{
  searchplos(terms = NA, fields = NA, toquery = NA,
    start = 0, limit = NA, returndf = TRUE,
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
}
\value{
  Number of search results (vis = FALSE), or number of
  search in a table and a histogram of results (vis =
  TRUE).
}
\description{
  Base function to search PLoS Journals
}
\examples{
\dontrun{
searchplos(terms='ecology', fields='id', limit = 1200)
searchplos('ecology', 'id,publication_date', limit = 2)
searchplos('ecology', 'id,title', limit = 2)
searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0, limit=250)
searchplos(terms="*:*", fields='id', toquery=list('cross_published_journal_key:PLoSONE',year=2010), start=0, limit=750)
searchplos(terms="*:*", fields='id',
   toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'),
   start=0, limit=250)
}
}

