\name{plosword}
\alias{plosword}
\title{Search results on a keyword over all fields in PLoS Journals.}
\usage{
  plosword(terms, vis = FALSE,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms (character)}

  \item{vis}{visualize results in bar plot or not (TRUE or
  FALSE)}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  Number of search results (vis = FALSE), or number of
  search in a table and a histogram of results (vis =
  TRUE).
}
\description{
  Search results on a keyword over all fields in PLoS
  Journals.
}
\examples{
plosword('Helianthus')
plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')
out <- plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')
out[[1]] # results in a data frame
out[[2]] # results in a bar plot
}

