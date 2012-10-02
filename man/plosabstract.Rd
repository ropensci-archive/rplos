\name{plosabstract}
\alias{plosabstract}
\title{Search PLoS Journals abstracts.}
\usage{
  plosabstract(terms = NULL, fields = NULL, limit = NULL,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{search terms for article abstract
  (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{results}{print results or not (TRUE or FALSE)}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}
}
\value{
  Abstract content in a list, named by their DOIs to
  facilitate further research on each paper.
}
\description{
  Search PLoS Journals abstracts.
}
\examples{
\dontrun{
plosabstract(terms = 'drosophila', fields='abstract', limit=10)
plosabstract(terms = 'drosophila', fields='materials_and_methods', limit = 5)
}
}

