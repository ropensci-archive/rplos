\name{articlelength}
\alias{articlelength}
\title{articlelength.R   Get article length}
\usage{
  articlelength(id = NA, fields = NA, limit = NA,
    searchin = NA, url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{id}{article identifier DOI = id, or subject area,
  e.g.: 'ecology'}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{searchin}{search field to search in (character)}

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
  length of articles (no. words)
}
\description{
  articlelength.R Get article length
}
\examples{
\dontrun{
 articlelength("10.1371/journal.pone.0004045", "body")
 articlelength("10.1371/journal.pone.0004045", "everything")
 articlelength("10.1371/journal.pone.0004045", "title")
 articlelength("ecology", "materials_and_methods", 500, "subject")
 articlelength("ecology", "results_and_discussion", 500, "subject")
}
}

