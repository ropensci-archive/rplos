<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

rplos tutorial
=====

The `rplos` package interacts with the API services of [PLoS](http://www.plos.org/) (Public Library of Science) Journals. In order to use `rplos`, you need to obtain [your own key](http://api.plos.org/registration/) to their API services. Instruction for obtaining and installing keys so they load automatically when you launch R are on our GitHub Wiki page [Installation and use of API keys](https://github.com/ropensci/rOpenSci/wiki/Installation-and-use-of-API-keys).

This tutorial will go through three use cases to demonstrate the kinds
of things possible in `rplos`.

* Search across PLoS papers in various sections of papers
* Search for terms and visualize results as a histogram OR as a plot through time
* Text mining of scientific literature

### Load package from CRAN


```r
install.packages("rplos")
```



```r
library(rplos)
```


### Search across PLoS papers in various sections of papers

`searchplos` is a general search, and in this case searches for the term
**Helianthus** and returns the DOI's of matching papers


```r
searchplos(terms = "Helianthus", fields = "id", limit = 5)
```

```
                            id
1 10.1371/journal.pone.0057533
2 10.1371/journal.pone.0045899
3 10.1371/journal.pone.0037191
4 10.1371/journal.pone.0051360
5 10.1371/journal.pone.0070347
```


Get only full article DOIs


```r
searchplos(terms = "*:*", fields = "id", toquery = "doc_type:full", start = 0, 
    limit = 20)
```

```
                             id
1  10.1371/journal.pgen.1001387
2  10.1371/journal.pone.0058892
3  10.1371/journal.pone.0015116
4  10.1371/journal.pgen.1001385
5  10.1371/journal.pone.0015114
6  10.1371/journal.pone.0030759
7  10.1371/journal.pone.0015112
8  10.1371/journal.pone.0030758
9  10.1371/journal.pone.0015111
10 10.1371/journal.pone.0058887
11 10.1371/journal.pone.0024514
12 10.1371/journal.pone.0030762
13 10.1371/journal.pone.0071223
14 10.1371/journal.pone.0030761
15 10.1371/journal.pone.0024513
16 10.1371/journal.pone.0024512
17 10.1371/journal.pone.0058890
18 10.1371/journal.pone.0030760
19 10.1371/journal.pgen.1001384
20 10.1371/journal.pone.0024511
```


Get DOIs for only PLoS One articles


```r
searchplos(terms = "*:*", fields = "id", toquery = "cross_published_journal_key:PLoSONE", 
    start = 0, limit = 15)
```

```
                                                    id
1                    10.1371/journal.pone.0071225/body
2            10.1371/journal.pone.0071225/introduction
3  10.1371/journal.pone.0071225/results_and_discussion
4   10.1371/journal.pone.0071225/materials_and_methods
5  10.1371/journal.pone.0071225/supporting_information
6                         10.1371/journal.pone.0058892
7                   10.1371/journal.pone.0058892/title
8                10.1371/journal.pone.0058892/abstract
9              10.1371/journal.pone.0058892/references
10                   10.1371/journal.pone.0058892/body
11           10.1371/journal.pone.0058892/introduction
12 10.1371/journal.pone.0058892/results_and_discussion
13  10.1371/journal.pone.0058892/materials_and_methods
14                        10.1371/journal.pone.0015116
15                  10.1371/journal.pone.0015116/title
```


Get DOIs for full article in PLoS One


```r
searchplos(terms = "*:*", fields = "id", toquery = list("cross_published_journal_key:PLoSONE", 
    "doc_type:full"), start = 0, limit = 20)
```

```
                             id
1  10.1371/journal.pone.0058892
2  10.1371/journal.pone.0015116
3  10.1371/journal.pone.0015114
4  10.1371/journal.pone.0030759
5  10.1371/journal.pone.0015112
6  10.1371/journal.pone.0030758
7  10.1371/journal.pone.0015111
8  10.1371/journal.pone.0058887
9  10.1371/journal.pone.0024514
10 10.1371/journal.pone.0030762
11 10.1371/journal.pone.0071223
12 10.1371/journal.pone.0030761
13 10.1371/journal.pone.0024513
14 10.1371/journal.pone.0024512
15 10.1371/journal.pone.0058890
16 10.1371/journal.pone.0030760
17 10.1371/journal.pone.0024511
18 10.1371/journal.pone.0021422
19 10.1371/journal.pone.0062009
20 10.1371/journal.pone.0030767
```


Serch for many terms


```r
terms <- c("ecology", "evolution", "science")
lapply(terms, function(x) searchplos(x, limit = 2))
```

```
[[1]]
                            id
1 10.1371/journal.pone.0059813
2 10.1371/journal.pone.0001248

[[2]]
                            id
1 10.1371/journal.pbio.0050030
2 10.1371/journal.pbio.0030245

[[3]]
                            id
1 10.1371/journal.pbio.0020122
2 10.1371/journal.pbio.1001166
```


### Search on specific sections

A suite of functions were created as light wrappers around `searchplos` as a shorthand to search specific sections of a paper. 

* `plosauthor` searchers in authors
* `plosabstract` searches in abstracts
* `plostitle` searches in titles
* `plosfigtabcaps` searches in figure and table captions
* `plossubject` searches in subject areas

`plosauthor` searches across authors, and in this case returns the authors of the matching papers. the fields parameter determines what is returned


```r
plosauthor(terms = "Eisen", fields = "author", limit = 10)
```

```
                                           author
1                                Jonathan A Eisen
2                                Jonathan A Eisen
3                   Garmay Leung, Michael B Eisen
4                 Richard W Lusk, Michael B Eisen
5  Leonid Teytelman, Michael B Eisen, Jasper Rine
6                 Richard W Lusk, Michael B Eisen
7                 Lars Eisen, Saul Lozano-Fuentes
8          Jonathan A Eisen, Catriona J MacCallum
9   Martin Wu, Sourav Chatterji, Jonathan A Eisen
10                 Peter A Combs, Michael B Eisen
```


`plosabstract` searches across abstracts, and in this case returns the id and title of the matching papers


```r
plosabstract(terms = "drosophila", fields = "id,title", limit = 5)
```

```
                            id
1 10.1371/journal.pbio.0040198
2 10.1371/journal.pbio.0030246
3 10.1371/journal.pone.0012421
4 10.1371/journal.pbio.0030389
5 10.1371/journal.pbio.1000342
                                                                      title
1                                                               All for All
2                               School Students as Drosophila Experimenters
3                      Host Range and Specificity of the Drosophila C Virus
4               New Environments Set the Stage for Changing Tastes in Mates
5 Variable Transcription Factor Binding: A Mechanism of Evolutionary Change
```


`plostitle` searches across titles, and in this case returns the title and journal of the matching papers


```r
plostitle(terms = "drosophila", fields = "title,journal", limit = 10)
```

```
                      journal
1                PLoS Biology
2                PLoS Biology
3                    PLoS ONE
4  PLoS Computational Biology
5                PLoS Biology
6               PLoS Genetics
7                PLoS Biology
8                PLoS Biology
9                    PLoS ONE
10                   PLoS ONE
                                                   title
1            School Students as Drosophila Experimenters
2          Identification of Drosophila MicroRNA Targets
3               A Tripartite Synapse Model in Drosophila
4             Parametric Alignment of Drosophila Genomes
5            Expression in Aneuploid Drosophila S2 Cells
6  Phenotypic Plasticity of the Drosophila Transcriptome
7       Reinforcement of Gametic Isolation in Drosophila
8            Combinatorial Coding for Drosophila Neurons
9                              A DNA Virus of Drosophila
10           Quantification of Food Intake in Drosophila
```


### Search for terms and visualize results as a histogram OR as a plot through time

`plosword` allows you to search for 1 to K words and visualize the results
as a histogram, comparing number of matching papers for each word


```r
out <- plosword(list("monkey", "Helianthus", "sunflower", "protein", "whale"), 
    vis = "TRUE")
out$table
```

```
  No_Articles       Term
1        6154     monkey
2         196 Helianthus
3         509  sunflower
4       64832    protein
5         702      whale
```

```r
out$plot
```

![plot of chunk plosword](figure/plosword.png) 


You can also pass in curl options, in this case get verbose information on the curl call.


```r
plosword("Helianthus", callopts = list(verbose = TRUE))
```

```
Number of articles with search term 
                                196 
```


### Visualize terms

`plot_througtime` allows you to search for up to 2 words and visualize the results as a line plot through time, comparing number of articles matching through time. Visualize with the ggplot2 package, only up to two terms for now.


```r
plot_throughtime(terms = "phylogeny", limit = 200, gvis = FALSE)
```

![plot of chunk throughtime1](figure/throughtime1.png) 



```r
plot_throughtime(list("drosophila", "monkey"), 100)
```

![plot of chunk throughtime2](figure/throughtime2.png) 


OR using google visualizations through the googleVis package, check it your self using, e.g.


```r
plot_throughtime(terms = list("drosophila", "flower"), limit = 200, gvis = TRUE)
```


...And a google visualization will render on your local browser and you
can play with three types of plots (point, histogram, line), all through
time. The plot is not shown here, but try it out for yourself!!
