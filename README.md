rplos
=====

[![Build Status](https://api.travis-ci.org/ropensci/rplos.png)](https://travis-ci.org/ropensci/rplos)
[![Build status](https://ci.appveyor.com/api/projects/status/m5lek0xawvgi5bwc/branch/master)](https://ci.appveyor.com/project/sckott/rplos/branch/master)

### Install

You can get this package at CRAN [here](http://cran.r-project.org/web/packages/rplos/), or install it within R by doing

```r
install.packages("rplos")
```

Or install the development version with `devtools::install_github()`:

```r
install.packages("devtools")
require(devtools)
install_github("rplos", "rOpenSci")
require(rplos)
```

### What is this?

`rplos` is a package for accessing full text articles from the Public Library of Science journals using their API.

### Information

Get your PLoS API key [here](http://alm.plos.org/)

Put your API key in your .Rprofile file using exactly this:
options(PlosApiKey = "YOURPLOSAPIKEY"),
and the functions within this package will be able to use your API key without you having to enter it every time you run a search.

rplos tutorial at rOpenSci website [here](http://ropensci.github.io/rplos/)

PLoS API documentation [here](http://api.plos.org/)

Crossref API documentation [here](http://random.labs.crossref.org/) and [here](http://help.crossref.org/#home). Note that we are working on a new package `rcrossref` with a much fuller implementation of R functions for all Crossref endpoints.

### Quick start


#### Search for the term ecology, and return id (DOI) and publication date, limiting to 5 items

```r
searchplos('ecology', 'id,publication_date', limit = 5)
```

```r
                            id     publication_date
1 10.1371/journal.pone.0059813 2013-04-24T00:00:00Z
2 10.1371/journal.pone.0001248 2007-11-28T00:00:00Z
3 10.1371/journal.pone.0017342 2011-03-09T00:00:00Z
4 10.1371/journal.pbio.0020072 2004-03-16T00:00:00Z
5 10.1371/journal.pone.0054689 2013-01-23T00:00:00Z
```

#### Visualize word use across articles

```r
plosword(list('monkey','Helianthus','sunflower','protein','whale'), vis = 'TRUE')
```

![plosword](inst/assets/img/plosword.png)

## Meta

Please report any [issues or bugs](https://github.com/ropensci/rplos/issues).

License: CC0

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

To cite package `rplos` in publications use:

```coffee
To cite package ‘rplos’ in publications use:

  Scott Chamberlain, Carl Boettiger and Karthik Ram (2014). rplos: Interface to PLoS
  Journals search API.. R package version 0.4.0. https://github.com/ropensci/rplos

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {rplos: Interface to PLoS Journals search API.},
    author = {Scott Chamberlain and Carl Boettiger and Karthik Ram},
    year = {2014},
    note = {R package version 0.4.0},
    url = {https://github.com/ropensci/rplos},
  }
```

Get citation information for `rplos` in R doing `citation(package = 'rplos')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
