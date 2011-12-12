\name{plosfigtabcaps}
\alias{plosfigtabcaps}
\title{Search PLoS Journals figure and table captions.}
\usage{
  plosfigtabcaps(terms, fields = NA, limit = NA,
    numrecords = FALSE, url = "http://api.plos.org/search",
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{terms}{search terms}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields [see
  plosfields$field]}

  \item{limit}{number of results to return (integer)}

  \item{numrecords:}{print number of results only
  (logical)}

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
  Number of search results, and fields that you specify to
  return.
}
\description{
  Search PLoS Journals figure and table captions.
}
\examples{
\dontrun{
plosfigtabcaps('ecology', 'id', 500)
plosfigtabcaps('ecology', 'figure_table_caption', 10)
plosfigtabcaps('is', 'id', 2000)
plosfigtabcaps('ecology', 'id', 10, numrecords = 'FALSE')
}
}

