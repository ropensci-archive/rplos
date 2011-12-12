\name{plosviews}
\alias{plosviews}
\title{Search PLoS Journals by article views.}
\usage{
  plosviews(search, byfield = NA, views = "alltime",
    limit = NA, url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{search}{search terms (character)}

  \item{byfield}{field to search by, e.g., subject, author,
  etc. (character)}

  \item{views}{views all time (alltime) or views last 30
  days (last30) (character)}

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
  Number of search results (results = FALSE), or number of
  search results plus the results themselves (results =
  TRUE).
}
\description{
  Search PLoS Journals by article views.
}
\examples{
\dontrun{
plosviews('10.1371/journal.pone.0002154', 'id', 'alltime')
plosviews('10.1371/journal.pone.0002154', 'id', 'last30')
plosviews('10.1371/journal.pone.0002154', 'id', 'alltime,last30')
plosviews('ecology', 'subject', 'alltime', 99)
plosviews('evolution', views = 'alltime', limit = 99)
plosviews('bird', views = 'alltime', limit = 99)
}
}

