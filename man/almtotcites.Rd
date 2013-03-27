\name{almtotcites}
\alias{almtotcites}
\title{Alt-metrics total citations from all sources.}
\usage{
  almtotcites(doi, key = NULL, curl = getCurlHandle())
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
  total no. data points recorded for this article from all
  sources
}
\description{
  Alt-metrics total citations from all sources.
}
\examples{
\dontrun{
almtotcites(doi = '10.1371/journal.pbio.0000012')
}
}

