# runs all R scripts 

# Knit Rmd -> md to auto-produce the correct header
# used by all .md files in the pages directroy
library(knitr)
opts_chunk$set(include=TRUE, echo=FALSE, message=FALSE)
knit('pages/agenda.Rmd', output = 'pages/agenda.md')

# cleanup, main directory
unlink(".Rhistory")

# cleanup, pages directory
unlink("pages/*.html")

# cleanup, reports directory
unlink("reports/*.html")
