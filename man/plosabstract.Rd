\name{plosabstract}
\alias{plosabstract}
\title{Search PLoS Journals abstracts.}
\usage{
  plosabstract(terms = NULL, fields = NULL, limit = NULL,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{search terms for article abstract
  (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}
}
\value{
  Abstract content, in addition to any other fields
  requested in a data.frame.
}
\description{
  Search PLoS Journals abstracts.
}
\examples{
\dontrun{
plosabstract(terms = 'drosophila', fields='abstract', limit=10)
plosabstract(terms = 'drosophila', fields='author', limit = 5)
}
}

