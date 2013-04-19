\name{almevents}
\alias{almevents}
\title{Retrieve PLoS article-level metrics (ALM) events.}
\usage{
  almevents(doi = NULL, pmid = NULL, pmcid = NULL,
    mdid = NULL,
    url = "http://alm.plos.org/api/v3/articles",
    months = NULL, days = NULL, source = NULL, key = NULL,
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

  \item{source}{The source to get events data from. You can
  pass in a character vector, like:
  \code{c("mendeley","crossref")}}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile (character)}

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
names(out) # names of sources
out <- out[!out \%in\% c("sorry, no events content yet","parser not written yet")] # remove those with no data
out[["pmc"]] # get the results for PubMed Central
out[["twitter"]] # get the results for twitter (boo, there aren't any)
out[c("twitter","crossref")] # get the results for two sources

# Another example
out <- almevents(doi="10.1371/journal.pone.0001543")
out <- out[!out \%in\% c("sorry, no events content yet","parser not written yet")] # remove those with no data
names(out)

# Another example
out <- almevents(doi="10.1371/journal.pone.0035869")
out <- out[!out \%in\% c("sorry, no events content yet","parser not written yet")] # remove those with no data
names(out)

# Two doi's
dois <- c('10.1371/journal.pone.0001543','10.1371/journal.pone.0040117')
out <- almevents(doi=dois)
out[[1]]
out[[2]]

# Specify a specific source
almevents(doi="10.1371/journal.pone.0035869", source="crossref")

# Specify two specific sources
almevents(doi="10.1371/journal.pone.0035869", source=c("crossref","twitter"))
}
}

