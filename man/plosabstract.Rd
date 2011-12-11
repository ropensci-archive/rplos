\name{plosabstract}
\alias{plosabstract}
\title{Search PLoS Journals abstracts.}
\usage{
  plosabstract(terms, fields = NA, limit = NA,
    results = FALSE, url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms for article abstract
  (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{results}{print results or not (TRUE or FALSE)}

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
  Number of search results (results = FALSE), or number of
  search results plus the results themselves (results =
  TRUE).
}
\description{
  Search PLoS Journals abstracts.
}
\examples{
plosabstract('drosophila', 'abstract', 9, 'FALSE')
plosabstract('drosophila',  limit = 5, results = 'TRUE')
}

