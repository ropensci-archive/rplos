\name{plos_todf}
\alias{plos_todf}
\title{Coerce output of searchplos, and similar fxns to data.frame's}
\usage{
  plos_todf(input, return = "data")
}
\arguments{
  \item{input}{Output from searchplos, or similar function
  call}

  \item{return}{One of data, highlighting, or both.}
}
\value{
  Either a data.frame or a list of two data.frame's
}
\description{
  Coerce output of searchplos, and similar fxns to
  data.frame's
}
\examples{
\dontrun{
out <- searchplos('ecology', 'id,publication_date', limit = 2, highlighting=TRUE)
plos_todf(out)
plos_todf(out, 'data')
plos_todf(out, 'high')

out <- searchplos(q="*:*", fl='id', fq=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), limit=15)
plos_todf(out, 'data') # returns a data.frame
plos_todf(out, 'high') # returns "No data"

out <- searchplos(terms = 'drosophila', fields='id,author', limit = 50)
plos_todf(out, 'data')
}
}

