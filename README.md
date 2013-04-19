# `rplos`

[![Build Status](https://api.travis-ci.org/ropensci/rplos.png)](https://travis-ci.org/ropensci/rplos)

### Install

You can get this package at CRAN [here](http://cran.r-project.org/web/packages/rplos/), or install it within R like

```R
install.packages("rplos")
```

Another option to install is install_github within Hadley Wickham's devtools package.

```R
install.packages("devtools")
require(devtools)
install_github("rplos", "rOpenSci")
require(rplos)
```

### What it is!?

`rplos` is a set of functions/package will access full text articles from the Public Library of Science journals using their API. 

### Some info

Get your PLoS API key [here](http://api.plos.org/)

Put your API key in your .Rprofile file using exactly this: 
options(PlosApiKey = "YOURPLOSAPIKEY"), 
and the functions within this package will be able to use your API key without you having to enter it every time you run a search. 

rplos tutorial at rOpenSci website [here](http://ropensci.org/tutorials/rplos-tutorial/)

PLoS API documentation [here](http://api.plos.org/)

Crossref API documentation [here](http://random.labs.crossref.org/) and [here](http://help.crossref.org/#home)

Visit our GitHub hosted website [here](http://ropensci.github.com/rplos/)

rplos is part of the [rOpenSci Project](http://ropensci.github.com)

### Quick start

#### Visualize word use across articles 

```R
plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')
```

![plosword](/inst/assets/img/plosword.png)

#### Get altmetrics data for a single paper, and visualize the total data across dates

```R
out <- alm(doi='10.1371/journal.pone.0001543', info='detail')
almplot(out, type='totalmetrics') # just totalmetrics data
```

![altmetrics](/inst/assets/img/altmetrics.png)

#### Output an easy to combine with other results data.frame

```R
alm(doi='10.1371/journal.pone.0035869', total_details=TRUE)

                                                       title     publication_date bloglines_citations
1 Research Blogs and the Discussion of Scholarly Information 2012-05-11T07:00:00Z                   0
  bloglines_total citeulike_shares citeulike_total connotea_citations connotea_total crossref_citations
1               0               22              22                  0              0                  2
  crossref_total nature_citations nature_total postgenomic_citations postgenomic_total pubmed_citations
1              2                4            4                     0                 0                1
  pubmed_total scopus_citations scopus_total counter_pdf counter_html counter_total
1            1                2            2           0            0         13598
  researchblogging_citations researchblogging_total biod_total wos_citations wos_total pmc_pdf pmc_html
1                          6                      6          0             1         1      85      429
  pmc_total facebook_shares facebook_comments facebook_likes facebook_total mendeley_shares
1       514              27                13             18             58              65
  mendeley_groups mendeley_total twitter_citations twitter_total wikipedia_citations wikipedia_total
1               8             73                48            48                   0               0
  scienceseeker_citations scienceseeker_total relativemetric_total
1                       3                   3                32898
```