<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{Full text}
%\VignetteEncoding{UTF-8}
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
#>  [1] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0031384&representation=XML"
#>  [2] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0031385&representation=XML"
#>  [3] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0107441&representation=XML"
#>  [4] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0000339&representation=XML"
#>  [5] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0046739&representation=XML"
#>  [6] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0061900&representation=XML"
#>  [7] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0061895&representation=XML"
#>  [8] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0077194&representation=XML"
#>  [9] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0015930&representation=XML"
#> [10] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0123741&representation=XML"
#> [11] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0031375&representation=XML"
#> [12] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0061894&representation=XML"
#> [13] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0123740&representation=XML"
#> [14] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0107433&representation=XML"
#> [15] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0000334&representation=XML"
#> [16] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0031374&representation=XML"
#> [17] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0092196&representation=XML"
#> [18] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0046713&representation=XML"
#> [19] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0046715&representation=XML"
#> [20] "http://www.plosone.org/article/fetchObject.action?uri=info:doi/10.1371/journal.pone.0000335&representation=XML"
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
#> [1] "Pancreatic adenocarcinoma, a desmoplastic disease, is the fourth leading cause of cancer-related death in the Western world due, in large part, to locally invasive primary tumor growth and ensuing metastasis. SPARC is a matricellular protein that governs extracellular matrix (ECM) deposition and maturation during tissue remodeling, particularly, during wound healing and tumorigenesis. In the present study, we sought to determine the mechanism by which lack of host SPARC alters the tumor microenvironment and enhances invasion and metastasis of an orthotopic model of pancreatic cancer. We identified that levels of active TGFÎ²1 were increased significantly in tumors grown in SPARC-null mice. TGFÎ²1 contributes to many aspects of tumor development including metastasis, endothelial cell permeability, inflammation and fibrosis, all of which are altered in the absence of stromal-derived SPARC. Given these results, we performed a survival study to assess the contribution of increased TGFÎ²1 activity to tumor progression in SPARC-null mice using losartan, an angiotensin II type 1 receptor antagonist that diminishes TGFÎ²1 expression and activation in vivo. Tumors grown in SPARC-null mice progressed more quickly than those grown in wild-type littermates leading to a significant reduction in median survival. However, median survival of SPARC-null animals treated with losartan was extended to that of losartan-treated wild-type controls. In addition, losartan abrogated TGFÎ² induced gene expression, reduced local invasion and metastasis, decreased vascular permeability and altered the immune profile of tumors grown in SPARC-null mice. These data support the concept that aberrant TGFÎ²1-activation in the absence of host SPARC contributes significantly to tumor progression and suggests that SPARC, by controlling ECM deposition and maturation, can regulate TGFÎ² availability and activation."
```

Extract reference lists, just give back first one from each for brevity sake


```r
lapply(out[2:3], function(x){
 xpathApply(xmlParse(x), "//ref-list/ref")[[1]]
})
```

```
#> $`10.1371/journal.pone.0031385`
#> <ref id="pone.0031385-Machesky1">
#>   <label>1</label>
#>   <element-citation publication-type="journal" xlink:type="simple">
#>     <person-group person-group-type="author">
#>       <name name-style="western">
#>         <surname>Machesky</surname>
#>         <given-names>LM</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Atkinson</surname>
#>         <given-names>SJ</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Ampe</surname>
#>         <given-names>C</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Vandekerckhove</surname>
#>         <given-names>J</given-names>
#>       </name>
#>       <name name-style="western">
#>         <surname>Pollard</surname>
#>         <given-names>TD</given-names>
#>       </name>
#>     </person-group>
#>     <year>1994</year>
#>     <article-title>Purification of a cortical complex containing two unconventional actins from Acanthamoeba by affinity chromatography on profilin- agarose.</article-title>
#>     <source>J Cell Biol</source>
#>     <volume>127</volume>
#>     <fpage>107</fpage>
#>     <lpage>115</lpage>
#>   </element-citation>
#> </ref> 
#> 
#> $`10.1371/journal.pone.0107441`
#> <ref id="pone.0107441-Daszak1">
#>   <label>1</label>
#>   <mixed-citation publication-type="journal" xlink:type="simple"><name name-style="western"><surname>Daszak</surname><given-names>P</given-names></name>, <name name-style="western"><surname>Cunningham</surname><given-names>AA</given-names></name>, <name name-style="western"><surname>Hyatt</surname><given-names>AD</given-names></name> (<year>2000</year>) <article-title>Emerging Infectious Diseases of Wildlifeâ Threats to Biodiversity and Human Health</article-title>. <source>Science (80â)</source> <volume>287</volume>: <fpage>443</fpage>â<lpage>449</lpage> Available: <ext-link ext-link-type="uri" xlink:href="http://www.sciencemag.org/cgi/doi/10.1126/science.287.5452.443" xlink:type="simple">http://www.sciencemag.org/cgi/doi/10.1126/science.287.5452.443</ext-link> Accessed 2 March 2013.</mixed-citation>
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
#> <<DocumentTermMatrix (documents: 3, terms: 5334)>>
#> Non-/sparse entries: 6513/9489
#> Sparsity           : 59%
#> Maximal term length: 109
#> Weighting          : term frequency (tf)
```

```r
findFreqTerms(dtm, lowfreq = 50)
```

```
#>  [1] "(figure"                          "actin"                           
#>  [3] "all"                              "amphibian"                       
#>  [5] "and"                              "are"                             
#>  [7] "âµm"                              "barbed"                          
#>  [9] "between"                          "bundles"                         
#> [11] "catesbeianus"                     "cell"                            
#> [13] "cells"                            "comet"                           
#> [15] "density"                          "each"                            
#> [17] "filament"                         "filaments"                       
#> [19] "for"                              "from"                            
#> [21] "grown"                            "growth"                          
#> [23] "have"                             "host"                            
#> [25] "individual"                       "individuals"                     
#> [27] "infection"                        "losartan"                        
#> [29] "low"                              "mg2+"                            
#> [31] "mice"                             "motility"                        
#> [33] "not"                              "number"                          
#> [35] "other"                            "our"                             
#> [37] "pan02"                            "sparc"                           
#> [39] "sparc+/+"                         "sparcâ\u0088\u0092/â\u0088\u0092"
#> [41] "species"                          "tail"                            
#> [43] "tgfî²1"                           "that"                            
#> [45] "the"                              "this"                            
#> [47] "total"                            "treatment"                       
#> [49] "tumor"                            "tumors"                          
#> [51] "was"                              "were"                            
#> [53] "wetland"                          "with"
```
