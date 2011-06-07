# function to format a URL for a specific article in a specific journal

formatarticleurl <- 
# Args:
#   doi: doi for article (numeric) 
#   journal: quoted journal name (character)
# Output: URL
# Examples:
#   myurl <- formatarticleurl(doi, 'PLoSBiology')
function(doi, journal) 
{
  paste(journalUrls[journal], '/article/info%3Adoi%2F', 
    str_replace(doi, '/', '%2F'), sep="")
}
