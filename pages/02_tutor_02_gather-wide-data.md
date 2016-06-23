---
layout: page
title: wide-form data table 
tagline: load cell calibration 
---

### Initialize the workspace.


```r
# set root directory for knitr to match the working directory for R
library(knitr) 
opts_knit$set(root.dir = '../')

# load libraries used by this script
library(readxl) # for read_excel() 
library(plyr)   # for laply
library(readr)  # for write_csv()
```

### Extract the raw data

From the earlier exploration, I know that the  calibration data set begins in the second column, row 9. I'll skip the first 7 rows, using row 8 as a heading.  


```r
raw_data_file <- 'data/2016-06-raw/calibration-data.xlsx'

# use row 8 as col_names row
raw_data <- read_excel(raw_data_file, col_names = TRUE, skip = 7)
head(raw_data, n = 4L)
```

```
## Source: local data frame [4 x 5]
## 
##   direction  (lb)  (mV)  (mV)  (mV)
##       (chr) (dbl) (dbl) (dbl) (dbl)
## 1      2 up   1.5    NA  29.9  30.2
## 2      3 up   2.5  51.1  49.4  49.7
## 3      4 up   3.5  70.4  70.0    NA
## 4      5 up   4.5  88.8  91.6    NA
```


### Rename columns

I could rename the columns manually.


```r
# copy the data frame so I can relabel the columns (not really "raw" data at this point)
data_table <- raw_data
names(data_table) <- c('test_point', 'input_lb', 'cycle1_mv', 'cycle2_mv', 'cycle3_mv')
head(data_table, n = 4L)
```

```
## Source: local data frame [4 x 5]
## 
##   test_point input_lb cycle1_mv cycle2_mv cycle3_mv
##        (chr)    (dbl)     (dbl)     (dbl)     (dbl)
## 1       2 up      1.5        NA      29.9      30.2
## 2       3 up      2.5      51.1      49.4      49.7
## 3       4 up      3.5      70.4      70.0        NA
## 4       5 up      4.5      88.8      91.6        NA
```

However, I might receive future data with additional cycles. I'd like to automate the naming of the cycle columns and not assume that I know the order of the columns. I'll use the *grep()* function to identify indices to the columns I'm interested in.


```r
# re-initialize the data table
data_table <- raw_data

# determine which col headings include 'direction', 'lb', 'mV'
is_a_direction_col <- grep('direction', names(data_table), ignore.case = TRUE)
is_a_force_col     <- grep('lb', names(data_table), ignore.case = TRUE)
is_a_mV_col        <- grep('mV', names(data_table), ignore.case = TRUE)

# for example, print one of these
print(is_a_mV_col)
```

```
## [1] 3 4 5
```

Thus, the *grep()* function  returns the index number of the column with the text noted.

We can use these indices to subset the names vector and assign new names to the first two columns.


```r
# reassign the first two column names
names(data_table)[is_a_direction_col] <- 'test_point'
names(data_table)[is_a_force_col]     <- 'input_lb'
```

The multiple mV readings columns should be relabeled *cycle 1*, *cycle 2*, etc.


```r
# subset the names vector extract the mV col names
mV_labels <- names(data_table)[is_a_mV_col]
print(mV_labels)
```

```
## [1] "(mV)" "(mV)" "(mV)"
```

Use the *plyr* package *laply()* function (instead of a *for* loop) to cycle through each name in the vector and replacing it with the name *cycle_i_mV*, where $i = 1:n$ and $n$ is the number of columns of mV readings. (Note, I use *laply()* because it converts a list to an array.)


```r
# rename the col labels as cycle_i, where i = 1, 2, 3 ...
new_cycle_labels <- laply(seq_along(mV_labels), function(i)
		names(mV_labels) <- paste0('cycle_', i))
print(new_cycle_labels)
```

```
## [1] "cycle_1" "cycle_2" "cycle_3"
```

```r
# assign these new labels to the correct columns in the data table
names(data_table)[is_a_mV_col] <- new_cycle_labels
data_table <- as.data.frame(data_table)
print(data_table)
```

```
##   test_point input_lb cycle_1 cycle_2 cycle_3
## 1       2 up      1.5      NA    29.9    30.2
## 2       3 up      2.5    51.1    49.4    49.7
## 3       4 up      3.5    70.4    70.0      NA
## 4       5 up      4.5    88.8    91.6      NA
## 5       4 dn      3.5    69.4    69.0      NA
## 6       3 dn      2.5    49.5    50.1      NA
## 7       2 dn      1.5    30.7    30.8      NA
## 8       1 dn      0.5     8.7    10.9      NA
```

```r
str(data_table)
```

```
## 'data.frame':	8 obs. of  5 variables:
##  $ test_point: chr  "2 up" "3 up" "4 up" "5 up" ...
##  $ input_lb  : num  1.5 2.5 3.5 4.5 3.5 2.5 1.5 0.5
##  $ cycle_1   : num  NA 51.1 70.4 88.8 69.4 49.5 30.7 8.7
##  $ cycle_2   : num  29.9 49.4 70 91.6 69 50.1 30.8 10.9
##  $ cycle_3   : num  30.2 49.7 NA NA NA NA NA NA
```

This is a form of the data set that is useful to include in a client report. I'll write this to file. 


```r
write_csv(data_table, 'data/set001_calibr_02_gather-wide-data.csv')
```

Next file is *set001_calibr_03_tidy-data.Rmd*.  

