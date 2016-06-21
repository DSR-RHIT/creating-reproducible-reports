# renders Rmd to md for gh-pages
# copies and removes files
# runs R scripts 

# load my functions
source('R/house_00_housekeeping-functions.R')

# ----------------------------------------------------
# knit Rmd -> md with the correct header for gh-pages
# this requires that the Rmd files DO NOT set knitr root.dir to project-WD
# instead use relative paths from their directories

# list only those directories where knit to md needed
paths_to_search <- c(".", "./pages")

# obtain file names with full paths
Rmd_to_knit <- list.files(path = paths_to_search
													, pattern = "\\.Rmd$"
													, full.names = TRUE)

# for comparison, find all Rmd files in the project
all_Rmd <- list.files(path = "."
											, pattern = "\\.Rmd$"
											, full.names = TRUE
											, recursive = TRUE)

# knit
sapply(Rmd_to_knit, knit_Rmd_to_md)

# print to console
knitted <- all_Rmd %in% Rmd_to_knit
not_knitted <- all_Rmd[!knitted]
cat("\n\nRmd files rendered by runall.R\n", Rmd_to_knit, sep = "\n")
cat("\nRmd files not rendered\n", not_knitted, sep = "\n")

# ----------------------------------------------------
# copy files to be used by particpants to the downloads folder

file.copy(from = "data/load-cell-calibr-L3.csv"
					, to = "downloads/")
file.copy(from = "data/load-cell-calibr-L6.csv"
					, to = "downloads/")
file.copy(from = "resources/images/load-cell-setup.png"
					, to = "downloads/")

# copy files used by me to test the report.Rmd
file.copy(from = "resources/images/load-cell-setup.png"
					, to = "reports/")



# ----------------------------------------------------
# cleanup, main directory
unlink(".Rhistory")
unlink("*.html")

# cleanup all readme.html
unlink("*/readme.html")

# # cleanup, assets directory
# unlink("assets/*.html")
# 
# # cleanup, pages directory
# unlink("pages/*.html")
# 
# # cleanup, reports directory
# unlink("reports/*.html")




