
# 	a runall script for the calibration report exercise
# 	runs all the code every time (NOT efficient)
#   if you want to do it right, use make
# 
# 	2016-08-24
# 	RAL

library(rmarkdown)

# data manipulation
render("scripts/01_calibr_data-reshaping.Rmd")
render("scripts/02_calibr_data-tidying.Rmd")

# graph
render("scripts/03_calibr_graph.Rmd")

# analysis
render("scripts/04_calibr_regression.Rmd")

# report
render("reports/05_calibr_report.Rmd")

