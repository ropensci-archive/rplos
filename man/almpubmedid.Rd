\name{almpubmedid}
\alias{almpubmedid}
\title{Get PubMed article ID by inputting the doi for the article.}
\usage{
  almpubmedid(doi, key = NULL, curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  The PubMed article ID.
}
\description{
  Get PubMed article ID by inputting the doi for the
  article.
}
\examples{
\dontrun{
almpubmedid(doi = '10.1371/journal.pbio.0000012')
}
}

