\name{plostitle}
\alias{plostitle}
\title{Search PLoS Journals titles.}
\usage{
  plostitle(terms, fields = NULL, limit = NULL,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{search terms for article titles (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}
}
\value{
  Titles, in addition to any other fields requested in a
  data.frame.
}
\description{
  Search PLoS Journals titles.
}
\examples{
\dontrun{
plostitle(terms='drosophila', fields='title', limit=99)
plostitle(terms='drosophila',  limit = 5)
}
}

