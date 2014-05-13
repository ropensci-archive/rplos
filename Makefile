all: move rmd2md cleanup

vignettes:
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rplos_vignette.Rmd"); knit("rplos_vignette.Rmd")'

move:
		cp inst/vign/rplos_vignette.md vignettes;\
		cp -r inst/vign/figure/ vignettes/figure/

pandoc:
		cd vignettes;\
		pandoc -H margins.sty rplos_vignette.md -o rplos_vignette.html --highlight-style=tango;\
		pandoc -H margins.sty rplos_vignette.md -o rplos_vignette.pdf --highlight-style=tango

rmd2md:
		cd vignettes;\
		cp rplos_vignette.md rplos_vignette.Rmd

cleanup:
		cd vignettes;\
		rm rplos_vignette.md
