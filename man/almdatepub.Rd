\name{almdatepub}
\alias{almdatepub}
\title{Get the date when the article was published.}
\usage{
  almdatepub(doi, get = NA, sleep = 0, key = NULL)
}
\arguments{
  \item{doi}{Digital object identifier for an article in
  PLoS Journals}

  \item{get}{Get year, month, or day; if unspecified, whole
  date returned.}

  \item{sleep}{Time (in seconds) before function sends API
  call - defaults to zero.  Set to higher number if you are
  using this function in a loop with many API calls.}

  \item{url}{the PLoS API url for the function (should be
  left to default)}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}
}
\value{
  Date when article was published.
}
\description{
  Get the date when the article was published.
}
\examples{
\dontrun{
almdatepub(doi='10.1371/journal.pone.0026871')
almdatepub('10.1371/journal.pone.0026871', 'year')

# Provide more than one DOI
dois <- c('10.1371/journal.pone.0026871','10.1371/journal.pone.0048868',
		'10.1371/journal.pone.0048705','10.1371/journal.pone.0048731')
almdatepub(doi=dois, get="month")
}
}

