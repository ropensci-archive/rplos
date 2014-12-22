#' Format a URL for a specific article in a specific PLoS journal.
#'
#' @export
#' @keywords internal
#' @param doi digital object identifier for an article in PLoS Journals
#' @param journal quoted journal name (character)
#' @return Get url for the article to use in your browser, etc.
#' @details Choose the journal abbreviation, and the appropriate base URL
#'    will be inclued in the built URL.  Options are:
#'    PLoSBiology, PLoSGenetics, PLoSComputationalBiology, PLoSMedicine,
#'	  PLoSONE, PLoSNeglectedTropicalDiseases, or PLoSPathogens.
#' @examples \dontrun{
#' formatarticleurl(doi="10.1371/journal.pone.0004045", journal='PLoSONE')
#' }
formatarticleurl <- function(doi, journal)
{
  journalUrls <- c(  # string with all journal base url's
    PLoSBiology = 'http://www.plosbiology.org',
    PLoSGenetics = 'http://www.plosgenetics.org',
    PLoSComputationalBiology = 'http://www.ploscompbiol.org',
	  PLoSMedicine = 'http://www.plosmedicine.org',
	  PLoSONE = 'http://www.plosone.org',
	  PLoSNeglectedTropicalDiseases = 'http://www.plosntds.org',
	  PLoSPathogens = 'http://www.plospathogens.org'
  )
  paste(journalUrls[journal], '/article/info%3Adoi%2F',
    gsub('/', '%2F', doi), sep="")
}
