\name{almevents}
\alias{almevents}
\title{Retrieve PLoS article-level metrics (ALM) events.}
\usage{
  almevents(doi = NULL, pmid = NULL, pmcid = NULL,
    mdid = NULL, months = NULL, days = NULL, key = NULL,
    url = "http://alm.plos.org/api/v3/articles",
    curl = getCurlHandle())
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals (character)}

  \item{pmid}{PubMed object identifier (numeric)}

  \item{pmcid}{PubMed Central object identifier (numeric)}

  \item{mdid}{Mendeley object identifier (character)}

  \item{months}{Number of months since publication to
  request historical data for.  See details for a note.
  (numeric)}

  \item{days}{Number of days since publication to request
  historical data for.  See details for a note. (numeric)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile (character)}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  PLoS altmetrics as data.frame's.
}
\description{
  Events are the details of the metrics that are counted
  related to PLoS papers.
}
\details{
  You can only supply one of the parmeters doi, pmid,
  pmcid, and mdid.

  By default, this function now returns json. Other data
  return formats have been removed for simplicity. Get in
  touch if you want them added back.

  Queries for up to 100 articles at a time will be
  supported soon.

  If you supply both the days and months parameters, days
  takes precedence, and months is ignored.
}
\examples{
\dontrun{
almevents(doi="10.1371/journal.pone.0029797")

# two doi's
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117')
almevents(doi=dois)
}
}

