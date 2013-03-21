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

  Query for as many articles at a time as you like. Though
  queries are broken up in to smaller bits of 30
  identifiers at a time.

  If you supply both the days and months parameters, days
  takes precedence, and months is ignored.

  You can get events from many different sources. After
  calling almevents, then index the output by the data
  provider you want. The options are: bloglines, citeulike,
  connotea, crossref, nature, postgenomic, pubmed, scopus,
  plos, researchblogging, biod, webofscience, pmc,
  facebook, mendeley, twitter, wikipedia, and
  scienceseeker.

  Beware that some data source are not parsed yet, so there
  may be event data but it is not provided yet as it is so
  messy to parse.
}
\examples{
\dontrun{
# For one article
out <- almevents(doi="10.1371/journal.pone.0029797")
out[["pmc"]] # get the results for PubMed Central
out[["twitter"]] # get the results for twitter (boo, there aren't any)
out[c("scienceseeker","crossref")] # get the results for two sources

# two doi's
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117')
almevents(doi=dois)
}
}

