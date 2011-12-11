\name{articlelength}
\alias{articlelength}
\title{Get article length of single paper by DOI, or of many papers as histogram.}
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
  Length of articles (no. words) as text (single paper) or
  histogram (>1 paper).
}
\description{
  Get article length of single paper by DOI, or of many
  papers as histogram.
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

