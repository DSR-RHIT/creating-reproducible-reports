# runs all R scripts 
# copies and removes files

# Knit Rmd -> md to auto-produce the correct header
# used by all .md files in the pages directroy
library(knitr)
opts_chunk$set(include=TRUE, echo=FALSE, message=FALSE)
knit('pages/agenda.Rmd', output = 'pages/agenda.md')

# copy files to be used by particpants to the downloads folder
file.copy(from = "data/load-cell-calibr-L3.csv"
					, to = "assets/downloads/")
file.copy(from = "data/load-cell-calibr-L6.csv"
					, to = "assets/downloads/")
file.copy(from = "assets/images/load-cell-setup.png"
					, to = "assets/downloads/")

# copy files used by me to test the report.Rmd
file.copy(from = "assets/images/load-cell-setup.png"
					, to = "reports/")

# cleanup, main directory
unlink(".Rhistory")

# cleanup, pages directory
unlink("pages/*.html")

# cleanup, reports directory
unlink("reports/*.html")



