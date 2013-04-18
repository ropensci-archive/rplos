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