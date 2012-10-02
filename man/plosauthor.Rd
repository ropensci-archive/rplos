\name{plosauthor}
\alias{plosauthor}
\title{Search PLoS Journals authors.}
\usage{
  plosauthor(terms, fields = NULL, limit = NULL,
    url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{authors to search for (character)}

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
  Author names, in addition to any other fields requested
  in a data.frame.
}
\description{
  Search PLoS Journals authors.
}
\examples{
\dontrun{
plosauthor(terms = 'johnson', fields = 'title,author', limit = 100)
plosauthor('johnson',  limit = 5)
plosauthor('johnson',  'title', limit = 5)
}
}

