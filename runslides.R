


# 
# library(rmarkdown)
# render("reports/slides_session_01.Rmd")

library(readr)
session_01 <- read_lines("reports/slides_session_01.Rmd") 

welcome_start <- which(session_01 %in% "## Welcome")
welcome_end   <- which(session_01 %in% "## Practitioners tell us:") - 1 

rr_ecosystem_start <- which(session_01 %in% "## Practitioners tell us:")
rr_ecosystem_end   <- which(session_01 %in% "## Welcome") - 1 
