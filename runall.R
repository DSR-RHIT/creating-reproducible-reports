# render scripts.Rmd to execute the R code and create md files
# create gh-pages from selected Rmds. 
# move and copy files 
# delete byproduct files

# load plyr before dplyr 
library(plyr)
suppressPackageStartupMessages(library(dplyr))



# ----------------------------------------------------
# render scripts.Rmd to execute their R code
library(rmarkdown)
Rmd_scripts <- list.files(path = "scripts"
													, pattern = "\\.Rmd$"
													, full.names = TRUE
													)

# files to omit
omit_files <- list.files(path = "scripts"
											, pattern = "_calibr_"
											, full.names = TRUE
)
omit_files <- c(omit_files, list.files(path = "scripts"
												 , pattern = "999"
												 , full.names = TRUE
												 )
								)
Rmd_scripts <- Rmd_scripts[! Rmd_scripts %in% omit_files]

sapply(Rmd_scripts, function(x) render(x))



# ----------------------------------------------------
# Rmds -> mds with edited YAML header for gh-pages
source('scripts/helper_01_create-gh-pages.R')

# clear old md files from pages dir
unlink("pages/*.md")

# plyr::failwith() allows completion even if an error occurs
sapply(Rmd_scripts, failwith(NULL, Rmd_to_gh_pages))



# ----------------------------------------------------
# move and copy files 

# move index.md from pages to top level
file.rename(from = 'pages/index.md', to = './index.md')

# copy participant files to the downloads folder
download_dir <- "resources/downloads/"
file.copy(from = "data/007_wide-data.csv"
					, to = download_dir
)
file.copy(from = "resources/images/load-cell-setup-786x989px.png"
					, to = download_dir
)

# copy image up one level for use by my "student" Rmds
file.copy(from = "resources/images/load-cell-setup-786x989px.png"
					, to = "resources/"
)




# ----------------------------------------------------
# delete byproduct files
unlink("./*.html")
unlink("pages/*.html")
unlink("reports/*.html")
unlink("scripts/*.html")

unlink("scripts/*.md")
unlink(".Rhistory")



# last line
