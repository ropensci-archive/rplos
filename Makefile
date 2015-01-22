all: vignettes move rmd2md

vignettes:
		cd inst/vign;\
		Rscript --vanilla -e 'library(knitr); knit("rplos_vignette.Rmd")'

move:
		cp inst/vign/rplos_vignette.md vignettes;\
		cp -r inst/vign/figure/ vignettes/figure/

rmd2md:
		cd vignettes;\
		mv rplos_vignette.md rplos_vignette.Rmd
