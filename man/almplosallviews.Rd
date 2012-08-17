\name{almplosallviews}
\alias{almplosallviews}
\title{Get PLoS altmetrics as xml, json, or csv.}
\usage{
  almplosallviews(doi, source_ = NULL, events = NULL,
    history = NULL, downform = NA, sleep = 0,
    url = "http://alm.plos.org/articles",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{source_}{source, one of counter, mpc, pubmed,
  crossref, scopus, wos, citeulike, nature,
  researchblogging, connotea, bloglines, postgenomic}

  \item{events}{include the individual citing document
  URIs, grouped by source (logical)}

  \item{history}{include a historical record of citation
  counts per month (cumulative), grouped by source
  (logical)}

  \item{downform}{download format (json, xml or csv)}

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
  PLoS altmetrics as xml, json, or csv.
}
\description{
  Get PLoS altmetrics as xml, json, or csv.
}
\examples{
\dontrun{
almplosallviews('10.1371/journal.pbio.0000012', 'counter', 1, 1, 'xml')
almplosallviews('10.1371/journal.pbio.0000012', 'crossref', 1, 0, 'json')
almplosallviews('10.1371/journal.pbio.0000012', 'citeulike', 0, 0, 'json')
almplosallviews('10.1371/journal.pone.0002554', 'facebook', 1, 1, 'json')
almplosallviews('10.1371/journal.pone.0002554', 'mendeley', 0, 1, 'json')

# DOI that does not work, gives NA so that looping isn't interrupted
almplosallviews("10.1371/journal.pone.002699", 'citeulike', F, F, 'json')
}
}

