\name{plosfigtabcaps}
\alias{plosfigtabcaps}
\title{Search PLoS Journals figure and table captions.}
\usage{
  plosfigtabcaps(terms, fields = NA, limit = NA,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  Fields that you specify to return in a data.frame, along
  with the DOI's found.
}
\description{
  Search PLoS Journals figure and table captions.
}
\examples{
\dontrun{
plosfigtabcaps('ecology', 'id', 500)
plosfigtabcaps('ecology', 'figure_table_caption', 10)
}
}

