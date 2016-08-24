# render Rmd to create md 
# create gh-pages from Rmd
# move and copy files 
# delete byproduct files

# load plyr before dplyr 
library(plyr)
suppressMessages(library(dplyr))

# read the function for editing the md header 
source('scripts/helper_01_create-gh-pages.R')

# render Rmd scripts for pages only
library(rmarkdown)
Rmd_page_scripts <- list.files(path = "pages"
													, pattern = "\\.Rmd$"
													, full.names = TRUE
													)
sapply(Rmd_page_scripts, function(x) render(x))

# edit the md header for gh-pages
sapply(Rmd_page_scripts, failwith(NULL, Rmd_to_gh_pages))

# render index and move to main directory
render("scripts/index.Rmd")
sapply("scripts/index.Rmd", failwith(NULL, Rmd_to_gh_pages))
file.rename(from = 'scripts/index.md', to = './index.md')

# copy participant files to the downloads folder
file.copy(from = "data/007_wide-data.csv"
					, to = "resources/downloads/"
)
file.copy(from = "data/008_wide-data_6-cycles.csv"
					, to = "resources/downloads/"
)
file.copy(from = "resources/images/load-cell-setup-786x989px.png"
					, to = "resources/downloads/"
)
# copy image up one level for my Rmds that mimic the student files
file.copy(from = "resources/images/load-cell-setup-786x989px.png"
					, to = "resources/"
)
# copy word template one level up
file.copy(from = "resources/docs/mystyles-01.docx"
					, to = "resources/"
)

# delete byproduct files
unlink("./*.html")
unlink("pages/*.html")
unlink("reports/*.html")
unlink("scripts/*.html")
unlink(".Rhistory")

# compile slides, html is the output
library(rmarkdown)
render("reports/slides_session_01.Rmd")
render("reports/slides_session_02.Rmd")




# unlink("scripts/*.md")
# # files to omit
# omit_files <- list.files(path = "scripts"
# 											, pattern = "_calibr_"
# 											, full.names = TRUE
# )
# omit_files <- c(omit_files, list.files(path = "scripts"
# 												 , pattern = "999"
# 												 , full.names = TRUE
# 												 )
# 								)
# Rmd_scripts <- Rmd_scripts[! Rmd_scripts %in% omit_files]

# last line
