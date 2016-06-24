---
layout: page
title: initial data examination 
tagline: load cell calibration 
---


### Initialize the workspace.


```r
# set root directory for knitr to match the working directory for R
library(knitr) 
opts_knit$set(root.dir = '../')

# load libraries used by this script
library(readxl) # for read_excel() 
library(dplyr)  # for pipe %>%
library(readr)  # for write_csv()
```

### Look at the raw data

Data file received 2016-06-10. 


```r
# assign the relative path to the file for read_excel()
raw_data_file <- 'data/2016-06-raw/calibration-data.xlsx'
```

Use the *readxl* package just to look at the first few rows of the data set. 


```r
# set col_names to FALSE to check if the file has more than one row of headings
raw_data <- read_excel(raw_data_file, col_names = FALSE)
head(raw_data, n = 10L)
```

```
## Source: local data frame [10 x 6]
## 
##                             X0             X1            X2      X3
##                          (chr)          (chr)         (chr)   (chr)
## 1   Load cell calibration data             NA            NA      NA
## 2  Omega LCL-005, 0-5 lb range             NA            NA      NA
## 3       Test run on 2016-06-05             NA            NA      NA
## 4            By Richard Layton             NA            NA      NA
## 5                           NA             NA            NA      NA
## 6                           NA             NA            NA      NA
## 7                           NA Test point and Applied force Cycle 1
## 8                           NA      direction          (lb)    (mV)
## 9                           NA           2 up           1.5      NA
## 10                          NA           3 up           2.5    51.1
## Variables not shown: X4 (chr), X5 (chr)
```

### Save the meta-data

The *read_excel()* function has added the arbitrary column labels *X0*, *X1*, etc. The first column is meta-data. I'll separate it and save it. The calibration data set begins in the second column, row 9. 


```r
library(dplyr)
meta_data <- raw_data %>%
	select(X0) %>%
	as.data.frame()
head(meta_data, n = 8L)
```

```
##                            X0
## 1  Load cell calibration data
## 2 Omega LCL-005, 0-5 lb range
## 3      Test run on 2016-06-05
## 4           By Richard Layton
## 5                        <NA>
## 6                        <NA>
## 7                        <NA>
## 8                        <NA>
```

Remove the NAs; change the column name to match this file name.  


```r
meta_data <- meta_data %>%
	filter(X0 != 'NA') %>%
	rename(gather_001_loadcell.Rmd = X0) %>%
	as.data.frame()
meta_data
```

```
##       gather_001_loadcell.Rmd
## 1  Load cell calibration data
## 2 Omega LCL-005, 0-5 lb range
## 3      Test run on 2016-06-05
## 4           By Richard Layton
```

Write to file. 


```r
write_csv(meta_data, 'data/006_meta-data.csv')
```

Because *plyr* (if used in a subsequent script) has to be loaded before *dplyr*, I'll unload *dplyr*. 
 

```r
# unload dplyr in case plyr is loaded in a subsequent script.
# always load plyr before dplyr.
detach(package:dplyr,  unload = TRUE)
```

Next file is *set001_calibr_02_gather-wide-data.Rmd*. 
