\name{almdateupdated}
\alias{almdateupdated}
\title{Get the date when article was last updated.}
\usage{
  almdateupdated(doi, get = NA,
    url = "http://alm.plos.org/articles",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals.}

  \item{get}{Get year, month, or day; if unspecified, whole
  date returned.}

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
  Get the date when article was last updated.
}
\examples{
\dontrun{
almdateupdated('10.1371/journal.pone.0026871')
almdateupdated('10.1371/journal.pone.0026871', 'year')
}
}

