rplos
=====

[![Build Status](https://api.travis-ci.org/ropensci/rplos.png)](https://travis-ci.org/ropensci/rplos)

### Install

You can get this package at CRAN [here](http://cran.r-project.org/web/packages/rplos/), or install it within R by doing

```R
install.packages("rplos")
```

Another option to install is `install_github` within Hadley Wickham's devtools package.

```R
install.packages("devtools")
require(devtools)
install_github("rplos", "rOpenSci")
require(rplos)
```

### What is this?

`rplos` is a set of functions/package will access full text articles from the Public Library of Science journals using their API. 

### Information

Get your PLoS API key [here](http://api.plos.org/)

Put your API key in your .Rprofile file using exactly this: 
options(PlosApiKey = "YOURPLOSAPIKEY"), 
and the functions within this package will be able to use your API key without you having to enter it every time you run a search. 

rplos tutorial at rOpenSci website [here](http://ropensci.github.io/rplos/)

PLoS API documentation [here](http://api.plos.org/)

Crossref API documentation [here](http://random.labs.crossref.org/) and [here](http://help.crossref.org/#home)

### Quick start


#### Search for the term ecology, and return id (DOI) and publication date, limiting to 5 items

```R
searchplos('ecology', 'id,publication_date', limit = 5)

                            id     publication_date
1 10.1371/journal.pone.0059813 2013-04-24T00:00:00Z
2 10.1371/journal.pone.0001248 2007-11-28T00:00:00Z
3 10.1371/journal.pone.0017342 2011-03-09T00:00:00Z
4 10.1371/journal.pbio.0020072 2004-03-16T00:00:00Z
5 10.1371/journal.pone.0054689 2013-01-23T00:00:00Z
```

#### Visualize word use across articles 

```R
plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')
```

![plosword](/inst/assets/img/plosword.png)

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

