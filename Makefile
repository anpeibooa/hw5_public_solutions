hw5.html: hw5.Rmd data/wawa/wawa.rds data/sheetz/sheetz.rds
	Rscript -e "library(rmarkdown); render('hw5.Rmd')"
	
data/wawa/wawa.rds: R/parse_wawa.R data/wawa/all_wawa_stores.rds
	Rscript R/parse_wawa.R

data/wawa/all_wawa_stores.rds: R/get_wawa.R
	mkdir -p data/wawa
	Rscript R/get_wawa.R
	
data/sheetz/sheetz.rds: R/parse_sheetz.R data/sheetz/all_sheetz_stores.rds
	Rscript R/parse_sheetz.R
	
data/sheetz/all_sheetz_stores.rds: R/get_sheetz.R
	mkdir -p data/sheetz
	Rscript R/get_sheetz.R

.PHONY: clean_html clean_data
clean_html:
	rm hw5.html
	
clean_data:
	rm -rf data/