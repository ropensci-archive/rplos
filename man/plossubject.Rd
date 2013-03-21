\name{plossubject}
\alias{plossubject}
\title{Search PLoS Journals subjects.}
\usage{
  plossubject(terms, fields = NULL, limit = NULL,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{search terms for article subjects
  (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}
}
\value{
  Subject content, in addition to any other fields
  requested in a data.frame.
}
\description{
  Search PLoS Journals subjects.
}
\examples{
\dontrun{
plossubject(terms = 'ecology', fields = 'subject', limit = 9)
plossubject('ecology',  limit = 5)
plossubject('ecology',  fields = 'abstract', limit = 20)
}
}

