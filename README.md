# `rplos`

You can get this package at CRAN here: http://cran.r-project.org/web/packages/rplos/. 

Another option to install is install_github within Hadley's devtools package.

```R
install.packages("devtools")
require(devtools)
install_github("rplos", "rOpenSci")
require(rplos)
```

This set of functions/package will access full text articles from the Public Library of Science journals using their API. 

Get your PLoS API key here:  http://api.plos.org/

Put your API key in your .Rprofile file using exactly this: 
options(PlosApiKey = "YOURPLOSAPIKEY"), 
and the functions within this package will be able to use your API key without you having to enter it every time you run a search. 

rplos tutorial at rOpenSci website here: http://ropensci.org/tutorials/rplos-tutorial/

Visit our GitHub hosted website here: http://ropensci.github.com/rplos/