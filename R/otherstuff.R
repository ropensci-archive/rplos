##### PLoS API queries code
# require(RCurl)
# require(stringr)
# require(RJSONIO)

# read in data frame describing search fields, read in as package data
plosfields <- data(plosfields) 
# data(plosfields) # for when loading as package


# string with all journal base url's
journalUrls <- c( # journal specific URL's for later use in code
  PLoSBiology = 'http://www.plosbiology.org',
  PLoSGenetics = 'http://www.plosgenetics.org', 
	PLoSComputationalBiology = 'http://www.ploscompbiol.org',
	PLoSMedicine = 'http://www.plosmedicine.org',
	PLoSONE = 'http://www.plosone.org',
	PLoSNeglectedTropicalDiseases = 'http://www.plosntds.org',
	PLoSPathogens = 'http://www.plospathogens.org'
)


# Look at possible search fields for plos journals
# plosfields$field


