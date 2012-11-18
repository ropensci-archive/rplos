\name{alm}
\alias{alm}
\title{Retrieve PLoS altmetrics.}
\usage{
  alm(doi = NULL, pmid = NULL, pmcid = NULL, mdid = NULL,
    info = "detail", months = NULL, days = NULL,
    key = NULL,
    url = "http://alm.plos.org/api/v3/articles",
    curl = getCurlHandle())
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals (character)}

  \item{pmid}{PubMed object identifier (numeric)}

  \item{pmcid}{PubMed Central object identifier (numeric)}

  \item{mdid}{Mendeley object identifier (character)}

  \item{info}{One of summary, montly, or history
  (character)}

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
  See details for more information.
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
# A single DOI
out <- alm(doi='10.1371/journal.pone.0029797', info='detail')
out[["metrics"]] # get metrics summary data.frame
out[["history"]] # get metrics summary data.frame

# A single PubMed ID (pmid)
alm(pmid=22590526, info='detail')

# A single PubMed Central ID (pmcid)
alm(pmcid=212692, info='summary')

# A single Mendeley UUID (mdid)
alm(mdid="35791700-6d00-11df-a2b2-0026b95e3eb7", info='summary')

# Provide more than one DOI
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117',
		'10.1371/journal.pone.0029797','10.1371/journal.pone.0039395')
out <- alm(doi=dois, info="detail")
out[[1]][["metrics"]] # get data for the first DOI, and just the monthly avg. metrics

# Provide more than one pmid
pmids <- c(19300479, 19390606, 19343216)
out <- alm(pmid=pmids, info="detail")
out[[3]][["metrics"]] # get data for the third pmid, and just the monthly avg. metrics

# Getting just summary data
alm(doi='10.1371/journal.pone.0039395', info='summary')

# Using month and day arguments
out <- alm(doi='10.1371/journal.pone.0040117', days=30)
}
}

