\name{almtitle}
\alias{almtitle}
\title{almtitle.R   Alt-metrics title of article}
\usage{
  almtitle(doi, url = "http://alm.plos.org/articles",
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
  title of article
}
\description{
  almtitle.R Alt-metrics title of article
}
\examples{
\dontrun{
   almtitle('10.1371/journal.pbio.0000012')
}
}

