\name{crossref}
\alias{crossref}
\title{Lookup article info via CrossRef with DOI.}
\usage{
  crossref(doi, title = FALSE,
    url = "http://www.crossref.org/openurl/",
    key = getOption("CrossRefKey", stop("need an API key for Mendeley")),
    ..., curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{title}{return the title of the paper or not
  (defaults to FALSE)}

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
  Metadata from DOI in R's bibentry format.
}
\description{
  Lookup article info via CrossRef with DOI.
}
\examples{
\dontrun{
crossref("10.3998/3336451.0009.101")
<<<<<<< HEAD
print(crossref("10.3998/3336451.0009.101"), style="Bibtex")
print(crossref("10.3998/3336451.0009.101"), style="text")
=======
crossref("10.3998/3336451.0009.101", TRUE)
>>>>>>> 7c05a50fe21e06e27a4814b88a544d76ee98ad81
}
}

