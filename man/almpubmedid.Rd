\name{almpubmedid}
\alias{almpubmedid}
\title{almpubmedid.R   Alt-metrics PubMed article ID}
\usage{
  almpubmedid(doi, url = "http://alm.plos.org/articles",
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
  retrieves the PubMed article ID
}
\description{
  almpubmedid.R Alt-metrics PubMed article ID
}
\examples{
\dontrun{
   almpubmedid('10.1371/journal.pbio.0000012')
}
}

