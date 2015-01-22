<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{Full text}
-->

Full text
=====



Search functions in `rplos` can be used to get back full text in addition to any section of an article. However, if you prefer XML, this vignette is for you.

### Load package from CRAN


```r
install.packages("rplos")
```


```r
library('rplos')
```

### Get full text URLs

Create urls for full text articles in PLOS journals

Here's the URL for XML full text for the DOI `10.1371/journal.pone.0086169`


```r
full_text_urls(doi='10.1371/journal.pone.0086169')
```

```
#> [1] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0086169&representation=XML"
```

And for the DOI `10.1371/journal.pbio.1001845`


```r
full_text_urls(doi='10.1371/journal.pbio.1001845')
```

```
#> [1] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.1001845&representation=XML"
```

The function is vectorized, so you can pass in many DOIs


```r
full_text_urls(doi=c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
```

```
#> [1] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0086169&representation=XML"    
#> [2] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.1001845&representation=XML"
```

Use `searchplos()` to get a lot of DOIs, then get the URLs for full text XML


```r
dois <- searchplos(q = "*:*", fq='doc_type:full', limit=20)$data$id
full_text_urls(dois)
```

```
#>  [1] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.1000156&representation=XML" 
#>  [2] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.1000106&representation=XML" 
#>  [3] "http://www.plosmedicine.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pmed.1001197&representation=XML"
#>  [4] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040294&representation=XML" 
#>  [5] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0093878&representation=XML"     
#>  [6] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040247&representation=XML" 
#>  [7] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040243&representation=XML" 
#>  [8] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0094012&representation=XML"     
#>  [9] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040442&representation=XML" 
#> [10] "http://www.plosmedicine.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pmed.1001302&representation=XML"
#> [11] "http://www.plosmedicine.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pmed.1001318&representation=XML"
#> [12] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040419&representation=XML" 
#> [13] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040447&representation=XML" 
#> [14] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0094113&representation=XML"     
#> [15] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0050125&representation=XML" 
#> [16] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0050136&representation=XML" 
#> [17] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0050091&representation=XML" 
#> [18] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040116&representation=XML" 
#> [19] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040198&representation=XML" 
#> [20] "http://www.plosbiology.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pbio.0040358&representation=XML"
```

### Get XML

Get full text XML of PLOS papers given a DOI


```r
plos_fulltext(doi='10.1371/journal.pone.0086169')
```

```
#> 1 full-text articles retrieved 
#> Min. Length: 111132 - Max. Length: 111132 
#> DOIs: 10.1371/journal.pone.0086169 ... 
#> 
#> NOTE: extract xml strings like output['<doi>']
```

`plos_fulltext()` is vectorized, so you can pass in more than one DOI


```r
plos_fulltext(c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
```

```
#> 2 full-text articles retrieved 
#> Min. Length: 111132 - Max. Length: 143937 
#> DOIs: 10.1371/journal.pone.0086169 10.1371/journal.pbio.1001845 ... 
#> 
#> NOTE: extract xml strings like output['<doi>']
```

Get many DOIs, then index to get the full XML of the one you want (output not shown)


```r
dois <- searchplos(q = "*:*", fq='doc_type:full', limit=3)$data$id
out <- plos_fulltext(dois)
xml <- out[dois[1]][[1]]
```

Extract the abstract from the XML


```r
library("XML")
xpathSApply(xmlParse(xml), "//abstract/p", xmlValue)
```

```
#> [1] "Solving global health challenges in a sustainable manner depends on explicitly addressing scientific capacity-building needs, as well as establishing long-term, meaningful partnerships with colleagues in the developing world."
```

Extract reference lists, just give back first one from each for brevity sake


```r
lapply(out[2:3], function(x){
 xpathApply(xmlParse(x), "//ref-list/ref")[[1]]
})
```

```
#> $`10.1371/journal.pbio.1000106`
#> <ref id="pbio-1000106-b001">
#>   <label>1</label>
#>   <element-citation publication-type="journal" xlink:type="simple">
#>     <person-group>
#>       <name name-style="western">
#>         <surname>Stahl</surname>
#>         <given-names>FW</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Foss</surname>
#>         <given-names>HM</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Young</surname>
#>         <given-names>LS</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Borts</surname>
#>         <given-names>RH</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Abdullah</surname>
#>         <given-names>MF</given-names>
#>       </name>
#>       <etal/>
#>     </person-group>
#>     <year>2004</year>
#>     <article-title>Does crossover interference count in <named-content content-type="genus-species" xlink:type="simple">Saccharomyces cerevisiae</named-content>.</article-title>
#>     <source>Genetics</source>
#>     <volume>168</volume>
#>     <fpage>35</fpage>
#>     <lpage>48</lpage>
#>   </element-citation>
#> </ref> 
#> 
#> $`10.1371/journal.pmed.1001197`
#> <ref id="pmed.1001197-Crowther1">
#>   <label>1</label>
#>   <element-citation publication-type="journal" xlink:type="simple">
#>     <person-group person-group-type="author">
#>       <name name-style="western">
#>         <surname>Crowther</surname>
#>         <given-names>C</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Dodd</surname>
#>         <given-names>JM</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Hiller</surname>
#>         <given-names>JE</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Haslam</surname>
#>         <given-names>RR</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Robinson</surname>
#>         <given-names>JS</given-names>
#>       </name>
#>       <etal/>
#>     </person-group>
#>     <year>2012</year>
#>     <article-title>Planned vaginal birth or elective repeat caesarean: Patient preference restricted cohort with nested randomised trial.</article-title>
#>     <source>PLoS Med</source>
#>     <volume>9</volume>
#>     <fpage>e1001192</fpage>
#>     <comment>doi:<ext-link ext-link-type="uri" xlink:href="http://dx.doi.org/10.1371/journal.pmed.1001192" xlink:type="simple">10.1371/journal.pmed.1001192</ext-link></comment>
#>   </element-citation>
#> </ref>
```

Make a text corpus


```r
library("tm")
out_parsed <- lapply(out, function(x){
 xpathApply(xmlParse(x), "//body", xmlValue)
})
tmcorpus <- Corpus(VectorSource(out_parsed))
(dtm <- DocumentTermMatrix(tmcorpus))
```

```
#> <<DocumentTermMatrix (documents: 3, terms: 1752)>>
#> Non-/sparse entries: 2005/3251
#> Sparsity           : 62%
#> Maximal term length: 84
#> Weighting          : term frequency (tf)
```

```r
findFreqTerms(dtm, lowfreq = 50)
```

```
#> [1] "and"  "for"  "that" "the"
```
