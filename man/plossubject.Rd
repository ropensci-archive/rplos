\name{plossubject}
\alias{plossubject}
\title{Search PLoS Journals subjects.}
\usage{
  plossubject(terms, fields = NULL, limit = NULL,
    toquery = NULL,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{Search terms for article subjects
  (character)}

  \item{fields}{Fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{toquery}{Specific fields to query (if NA, all
  queried), in a comma separated string (character) [e.g.,
  'doc_type:full,year=2010'].}

  \item{limit}{Number of results to return (integer)}

  \item{key}{Your PLoS API key, either enter, or loads from
  .Rprofile}
}
\value{
  Subject content, in addition to any other fields
  requested in a data.frame.
}
\description{
  Search PLoS Journals subjects.
}
\details{
  See \url{http://www.plosone.org/taxonomy} for subject
  areas.
}
\examples{
\dontrun{
plossubject('marine ecology', limit = 5)[,1:4]
plossubject(terms='marine ecology',  fields = 'id,journal', limit = 20)
plossubject('museums', fields = 'id,journal', toquery='doc_type:full', limit = 9)
plossubject(terms='marine ecology', fields = 'id,journal', toquery=list('doc_type:full','!article_type_facet:"Issue\%20Image"'), limit = 9)
}
}

