\name{almplosallviews}
\alias{almplosallviews}
\title{Get PLoS altmetrics as xml, json, or csv.}
\usage{
  almplosallviews(doi, source_ = NA, citations = FALSE,
    history = FALSE, downform = NA, sleep = 0,
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

  \item{citations}{include the individual citing document
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
almplosallviews('10.1371/journal.pbio.0000012', 'counter', T, T, 'xml')
almplosallviews('10.1371/journal.pbio.0000012', 'crossref', F, F, 'json')
almplosallviews('10.1371/journal.pbio.0000012', 'citeulike', F, F, 'json')
almplosallviews("10.1371/journal.pone.002699", 'citeulike', F, F, 'json')
}
}

