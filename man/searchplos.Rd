\name{searchplos}
\alias{searchplos}
\title{Base function to search PLoS Journals}
\usage{
  searchplos(terms, fields = NA, limit = 1000,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

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
searchplos('ecology', 'id', 2)
searchplos('ecology', 'id', 1001)
searchplos('ecology', 'id,title', 2)
}
}

