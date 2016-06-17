# script to run an Rmd file, producing an md file with the correct header


library(knitr)
opts_chunk$set(include=TRUE, echo=FALSE, message=FALSE)

knit('pages/agenda.Rmd', output = 'pages/agenda.md')
