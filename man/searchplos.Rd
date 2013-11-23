\name{searchplos}
\alias{searchplos}
\title{Base function to search PLoS Journals}
\usage{
  searchplos(terms = NA, fields = "id", toquery = NA,
    sort = NA, highlighting = FALSE, start = 0, limit = NA,
    returndf = TRUE,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    sleep = 6, curl = getCurlHandle(), callopts = list())
}
\arguments{
  \item{terms}{search terms (character). You can search on
  specific fields by doing 'field:your query'. For example,
  a real query on a specific field would be
  'author:Smith'.}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields
  [type 'data(plosfields)', then 'plosfields'].}

  \item{toquery}{List specific fields to filter the query
  on (if NA, all queried).  The options for this parameter
  are the same as those for the fields parameter.  Note
  that using this parameter doesn't influence the actual
  query, but is used to filter the resuls to a subset of
  those you want returned. For example, if you want full
  articles only, you can do 'doc_type:full'. In another
  example, if you want only results from the journal PLOS
  One, you can do 'cross_published_journal_key:PLoSONE'.
  See journalnamekey() for journal abbreviations.}

  \item{sort}{Sort results according to a particular field,
  and specify ascending (asc) or descending (desc) after a
  space; see examples. For example, to sort the
  counter_total_all field in descending fashion, do
  sort='counter_total_all desc'}

  \item{highlighting}{If TRUE, text found matching your
  query given as a separate data.frame in output. If FALSE
  (default), nothing returned in the highlighting slot.}

  \item{start}{Record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{Number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{key}{Your PLoS API key, either enter as the key, or
  loads from .Rprofile.  See details.}

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
  Either a data.frame if returndf=TRUE, or a list if
  returndf=FALSE.
}
\description{
  Base function to search PLoS Journals
}
\details{
  Get a PLOS API key at \url{http://alm.plos.org/}. Note
  that the API key you recieve at that URL works for the
  PLOS ALM (article-level metrics) API as well. See the alm
  package
  \url{http://cran.r-project.org/web/packages/alm/index.html}
  to access PLOS ALM data.

  You can store your PLOS Search API key in your .Rprofile
  file so that you don't have to enter the key each
  function call. Open up your .Rprofile file on your
  computer, and put it an entry like:

  options(PlosApiKey = "your plos api key")
}
\examples{
\dontrun{
searchplos('ecology', 'id,publication_date', limit = 2)
searchplos('ecology', 'id,title', limit = 2)

# Get only full article DOIs
searchplos(terms="*:*", fields='id', toquery='doc_type:full', start=0,
limit=250)

# Get DOIs for only PLoS One articles
searchplos(terms="*:*", fields='id',
toquery='cross_published_journal_key:PLoSONE', start=0, limit=15)

# Get DOIs for full article in PLoS One
searchplos(terms="*:*", fields='id',
   toquery=list('cross_published_journal_key:PLoSONE', 'doc_type:full'),
   start=0, limit=50)

# Serch for many terms
library(plyr)
terms <- c('ecology','evolution','science')
llply(terms, function(x) searchplos(x, limit=2))

# Query to get some PLOS article-level metrics, notice difference between two outputs
out <- searchplos(terms="*:*", fields='id,counter_total_all,alm_twitterCount',
   toquery='doc_type:full')
out_sorted <- searchplos(terms="*:*", fields='id,counter_total_all,alm_twitterCount',
   toquery='doc_type:full', sort='counter_total_all desc')
head(out)
head(out_sorted)

# A list of articles about social networks that are popular on a social network
searchplos(terms="*:*", fields='id,alm_twitterCount',
   toquery=list('doc_type:full','subject:"Social networks"',
                'alm_twitterCount:[100 TO 10000]'),
   sort='counter_total_month desc')

# Show me all articles that have these two words less then about 15 words apart.
searchplos(terms='everything:"sports alcohol"~15', fields='title', toquery='doc_type:full')

# Now let's try to narrow our results to 7 words apart. Here I'm changing the ~15 to ~7
searchplos(terms='everything:"sports alcohol"~7', fields='title', toquery='doc_type:full')

# Now, lets also only look at articles that have seen some activity on twitter.
# Add "fq=alm_twitterCount:[1 TO *]" as a parameter within the toquery argument.
searchplos(terms='everything:"sports alcohol"~7', fields='alm_twitterCount,title',
   toquery=list('doc_type:full','alm_twitterCount:[1 TO *]'))
searchplos(terms='everything:"sports alcohol"~7', fields='alm_twitterCount,title',
   toquery=list('doc_type:full','alm_twitterCount:[1 TO *]'),
   sort='counter_total_month desc')

# Highlighting!! What is that? Setting highlighting=TRUE gives you back the usual
# fields you want, plus a separate data.frame of the places where the search terms
# were found
searchplos(terms='everything:"sports alcohol"~7', fields='alm_twitterCount,title',
   toquery=list('doc_type:full','alm_twitterCount:[1 TO *]'), highlighting=TRUE)

# Highlighting with lots of results
out <- searchplos(terms='everything:"experiment"', fields='id,title',
   toquery='doc_type:full', limit=1100, highlighting = TRUE)
lapply(out, head)

# Return partial doc parts
## Return Abstracts only
out <- searchplos(terms='*:*', fields='doc_partial_body,doc_partial_parent_id',
   toquery=list('doc_type:partial', 'doc_partial_type:Abstract'), limit=3)
## Return Title's only
out <- searchplos(terms='*:*', fields='doc_partial_body,doc_partial_parent_id',
   toquery=list('doc_type:partial', 'doc_partial_type:Title'), limit=3)
}
}
\seealso{
  plosauthor, plosabstract, plostitle, plosfigtabcaps
}

