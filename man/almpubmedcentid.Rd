\name{almpubmedcentid}
\alias{almpubmedcentid}
\title{Get PubMed Central article ID by inputting the doi for the article.}
\usage{
  almpubmedcentid(doi,
    url = "http://alm.plos.org/api/v3/articles",
    key = NULL, curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  The PubMed Central article ID.
}
\description{
  Get PubMed Central article ID by inputting the doi for
  the article.
}
\examples{
\dontrun{
almpubmedcentid(doi = '10.1371/journal.pbio.0000012')
}
}

