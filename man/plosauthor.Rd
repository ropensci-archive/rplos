\name{plosauthor}
\alias{plosauthor}
\title{Search PLoS Journals authors.}
\usage{
  plosauthor(terms, fields = NA, limit = NA,
    results = FALSE, url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{authors to search for (character)}

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
  Search PLoS Journals authors.
}
\examples{
\dontrun{
   plosauthor('johnson', 'title,author', 9999999, 'FALSE')
   plosauthor('johnson',  limit = 5, results = 'TRUE')
}
}

