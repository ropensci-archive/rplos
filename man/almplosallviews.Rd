\name{almplosallviews}
\alias{almplosallviews}
\title{Get PLoS altmetrics as xml, json, or csv.}
\usage{
  almplosallviews(doi, info = "detail", months = NULL,
    days = NULL,
    url = "http://alm.plos.org/api/v3/articles",
    key = NULL, curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{info}{One of summary or detail (character)}

  \item{months}{Number of months since publication to
  request historical data for.}

  \item{days}{Number of days since publication to request
  historical data for.}

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
  PLoS altmetrics as raw json or as list object.
}
\description{
  See details for more information.
}
\details{
  By default, this function now returns json. Other data
  return formats have been removed for simplicity. Get in
  touch if you want them added back. Queries for up to 100
  articles at a time are supported.
}
\examples{
\dontrun{
# A single DOI
out <- almplosallviews(doi='10.1371/journal.pone.0029797', info='detail')
out[["metrics"]] # get metrics summary data.frame

# Provide more than one DOI
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
out <- almplosallviews(doi=dois, info="detail")
out[[1]][["metrics"]]

# Getting just summary data
almplosallviews(doi='10.1371/journal.pone.0039395', info='summary')
dois <- c('10.1371/journal.pone.0040117',
		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
almplosallviews(doi=dois, info="detail")

# Using month and day arguments
out <- almplosallviews(doi='10.1371/journal.pone.0040117', days=30)
}
}

