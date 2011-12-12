\name{plot_throughtime}
\alias{plot_throughtime}
\title{Plot results through time for serach results from PLoS Journals.}
\usage{
  plot_throughtime(terms, limit = NA, gvis = FALSE,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms (character)}

  \item{limit}{number of results to return (integer)}

  \item{gvis}{use google visualization via the googleVis
  package (logical)}

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
  Plot results through time for serach results from PLoS
  Journals.
}
\examples{
\dontrun{
plot_throughtime('phylogeny', 300, gvis=FALSE)
plot_throughtime(list('drosophila','monkey'), 100)
plot_throughtime(list('drosophila','flower'), 100, TRUE)
}
}

