\name{almpubmedcentid}
\alias{almpubmedcentid}
\title{almpubmedcentid.R   Alt-metrics PubMed Central article ID}
\usage{
  almpubmedcentid(doi,
    url = "http://alm.plos.org/articles",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  retrieves the PubMed Central article ID
}
\description{
  almpubmedcentid.R Alt-metrics PubMed Central article ID
}
\examples{
\dontrun{
   almpubmedcentid('10.1371/journal.pbio.0000012')
}
}

