PASSWORD ?= $(shell bash -c 'read -s -p "Your PLOS API key: " pwd; echo $$pwd')

all: vignettes move rmd2md cleanup

vignettes:
		cd inst/vign;\
		Rscript --vanilla -e 'library(knitr); options(PlosApiKey = "$(PASSWORD)"); knit("rplos_vignette.Rmd")'

move:
		cp inst/vign/rplos_vignette.md vignettes;\
		cp -r inst/vign/figure/ vignettes/figure/

rmd2md:
		cd vignettes;\
		cp rplos_vignette.md rplos_vignette.Rmd

cleanup:
		cd vignettes;\
		rm rplos_vignette.md
