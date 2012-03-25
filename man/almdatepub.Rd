\name{almdatepub}
\alias{almdatepub}
\title{Get the date when the article was published.}
\usage{
  almdatepub(doi, get = NA, sleep = 0,
    url = "http://alm.plos.org/articles",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals}

  \item{get}{Get year, month, or day; if unspecified, whole
  date returned.}

  \item{sleep}{Time (in seconds) before function sends API
  call - defaults to zero.  Set to higher number if you are
  using this function in a loop with many API calls.}

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
  Date when article was published.
}
\description{
  Get the date when the article was published.
}
\examples{
\dontrun{
almdatepub('10.1371/journal.pone.0026871')
almdatepub('10.1371/journal.pone.0026871', 'year')
<<<<<<< HEAD
=======

# DOI that does not work, gives NA so that looping isn't interrupted
almdatepub(doi="10.1371/journal.pone.002699", get='year')
>>>>>>> 7c05a50fe21e06e27a4814b88a544d76ee98ad81
}
}

