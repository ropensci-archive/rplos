\name{plossubject}
\alias{plossubject}
\title{Search PLoS Journals subjects.}
\usage{
  plossubject(terms = NA, fields = "id", toquery = NA,
    sort = NA, highlighting = FALSE, start = 0, limit = NA,
    returndf = TRUE, sleep = 6,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    curl = getCurlHandle(), callopts = list())
}
\arguments{
  \item{terms}{search terms (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields
  [type 'data(plosfields)', then 'plosfields']}

  \item{toquery}{List specific fields to query (if NA, all
  queried). The possibilities for this parameter are the
  same as those for the fields parameter.}

  \item{sort}{Sort results according to a particular field,
  and specify ascending (asc) or descending (desc) after a
  space; see examples.}

  \item{highlighting}{If TRUE, text found matching your
  query given as a separate data.frame in output. If FALSE
  (default), highlighting results not returned.}

  \item{start}{Record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{Number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{key}{Your PLoS API key, either enter as the key, or
  loads from .Rprofile. See details.}

  \item{sleep}{Number of seconds to wait between requests.
  No need to use this for a single call to searchplos.
  However, if you are using searchplos in a loop or lapply
  type call, do sleep parameter is used to prevent your IP
  address from being blocked. You can only do 10 requests
  per minute, so one request every 6 seconds is about
  right.}

  \item{callopts}{Optional additional curl options
  (debugging tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  Subject content, in addition to any other fields
  requested in a data.frame.
}
\description{
  Search PLoS Journals subjects.
}
\details{
  You can store your PLOS Search API key in your .Rprofile
  file so that you don't have to enter the key each
  function call. Open up your .Rprofile file on your
  computer, and put it an entry like:

  options(PlosApiKey = "your plos api key")
}
\examples{
\dontrun{
plossubject('marine ecology', limit = 5)
plossubject(terms='marine ecology',  fields = 'id,journal,title', limit = 20)
plossubject(terms='marine ecology', fields = 'id,journal',
   toquery='doc_type:full', limit = 9)
plossubject(terms='marine ecology', fields = 'id,journal',
   toquery=list('doc_type:full','!article_type_facet:"Issue\%20Image"'),
   limit = 9)

# Highlighting
plossubject(terms='marine ecology', fields='id,title', toquery='doc_type:full',
   limit = 2, highlighting=TRUE)
}
}

