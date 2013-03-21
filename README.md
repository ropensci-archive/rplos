# `rplos`

## NOTE: You can install the branch `almv3` that interacts with the new version of the PLoS ALM API, by doing

```R
install.packages("devtools")
require(devtools)
install_github("rplos", "rOpenSci", "almv3")
require(rplos)
```




You can get this package at CRAN [here](http://cran.r-project.org/web/packages/rplos/). 

Another option to install is install_github within Hadley Wickham's devtools package.

```R
install.packages("devtools")
require(devtools)
install_github("rplos", "rOpenSci")
require(rplos)
```

This set of functions/package will access full text articles from the Public Library of Science journals using their API. 

Get your PLoS API key [here](http://api.plos.org/)

Put your API key in your .Rprofile file using exactly this: 
options(PlosApiKey = "YOURPLOSAPIKEY"), 
and the functions within this package will be able to use your API key without you having to enter it every time you run a search. 

rplos tutorial at rOpenSci website [here](http://ropensci.org/tutorials/rplos-tutorial/)

PLoS API documentation [here](http://api.plos.org/)

Crossref API documentation [here](http://random.labs.crossref.org/) and [here](http://help.crossref.org/#home)

Visit our GitHub hosted website [here](http://ropensci.github.com/rplos/)

rplos is part of the [rOpenSci Project](http://ropensci.github.com)