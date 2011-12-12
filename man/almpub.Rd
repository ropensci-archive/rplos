\name{almpub}
\alias{almpub}
\title{Get the date when article was last updated by inputting the doi for the article.}
\usage{
  almpub(doi, url = "http://alm.plos.org/articles",
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
  Date when article data was last updated.
}
\description{
  Get the date when article was last updated by inputting
  the doi for the article.
}
\examples{
\dontrun{
almpub('10.1371/journal.pbio.0000012')
}
}

