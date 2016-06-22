---
layout: page
title: tidying the data 
tagline: load cell calibration 
output: html_document
---

### Initialize the workspace.


```r
# set root directory for knitr to match the working directory for R
library(knitr) 
opts_knit$set(root.dir = '../')

# clear environment
rm(list=ls())

# load libraries used by this script
library(readr)   # for read_csv() and write_csv()
library(dplyr)   # for pipe %>%
library(tidyr)   # for gather()
library(stringr) # for str_split_fixed()
```

### Read the wide-form data


```r
wide_data <- read_csv('data/set001_calibr_02_gather-wide-data.csv')
```

```
## Error: 'data/set001_calibr_02_gather-wide-data.csv' does not exist in current working directory ('C:/Users/layton/C-Users-layton-docs/workshops').
```

```r
head(wide_data, n = 4L)
```

```
## Error in head(wide_data, n = 4L): object 'wide_data' not found
```

### Reshape the data from wide to long format

Data are best analyzed after they have been *tidied*, that is, every column is one variable and every row is one observation. The final tidy data set should have these columns:

- observation number
- cycle number
- test\_point number
- direction (up or down)
- input\_lb
- output\_mV

We start by rearranging the table to have the cycle numbers all in one column and the mV readings all in one column.


```r
# indices of which columns to gather
is_a_cycle_col <- grep('cycle', names(wide_data), ignore.case = TRUE)
```

```
## Error in grep("cycle", names(wide_data), ignore.case = TRUE): object 'wide_data' not found
```

```r
# convert to long form, 
# create new column 'cycle' to gather column headings 
# create new column 'output_mV' to gather numerical readings
tidy_data <- wide_data %>%
	gather(cycle, output_mV, is_a_cycle_col) %>%
	as.data.frame()
```

```
## Error in eval(expr, envir, enclos): object 'wide_data' not found
```

```r
print(tidy_data)
```

```
## Error in print(tidy_data): object 'tidy_data' not found
```

Examine the structure of the data frame and find there are 2 character columns and 2 numerical columns. The two numerical columns are the data the are used for the calibration curve. 


```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```

Now remove the test points for which there are no readings.


```r
tidy_data <- tidy_data %>%
	filter(!output_mV %in% NA)
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

```r
print(tidy_data)
```

```
## Error in print(tidy_data): object 'tidy_data' not found
```

```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```


### Add the observation number

The data are in the order observed, so we can add a column to list the observation number.


```r
tidy_data$observ <- row.names(tidy_data)
```

```
## Error in row.names(tidy_data): object 'tidy_data' not found
```

```r
print(tidy_data)
```

```
## Error in print(tidy_data): object 'tidy_data' not found
```

```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```

### Split the string variables

The *test_point* variable is a character string that can be split to form *test_point* and *direction* columns.


```r
split_column <- str_split_fixed(tidy_data$test_point, pattern = ' ', 2)
```

```
## Error in stri_split_regex(string, pattern, n = n, simplify = TRUE, opts_regex = attr(pattern, : object 'tidy_data' not found
```

```r
tidy_data <- tidy_data %>%
	mutate(N = split_column[ , 1]) %>%
	mutate(direction = split_column[ , 2])
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```

Remove the original *test_point* column and rename *N* as *test_point*


```r
tidy_data <- tidy_data %>%
	select(-test_point) %>%
	rename(test_point = N)
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```

Similarly, split the cycle string and keep only the cycle number, N. 


```r
split_column <- str_split_fixed(tidy_data$cycle, pattern = '_', 2)
```

```
## Error in stri_split_regex(string, pattern, n = n, simplify = TRUE, opts_regex = attr(pattern, : object 'tidy_data' not found
```

```r
tidy_data$cycle <- split_column[ , 2]
```

```
## Error in eval(expr, envir, enclos): object 'split_column' not found
```

```r
# arrange the column order
tidy_data <- tidy_data %>%
	select(observ, cycle, test_point, direction, input_lb, output_mV)
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

```r
print(tidy_data, row.names = FALSE)
```

```
## Error in print(tidy_data, row.names = FALSE): object 'tidy_data' not found
```

```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```


### Convert numerical strings to integers

The first three columns (observ, cycle, and test_point) are characters because they were split from character strings. For analysis, these may be better if converted to integers. 


```r
tidy_data <- tidy_data %>%
	mutate(observ = as.integer(observ)) %>%
	mutate(cycle = as.integer(cycle)) %>%
	mutate(test_point = as.integer(test_point))
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```

### Save the tidy data for analysis

These data are saved in CSV form for calibration analysis. 


```r
write_csv(tidy_data, 'data/set001_calibr_03_tidy-data.csv')
```

```
## Error in is.data.frame(x): object 'tidy_data' not found
```
 

```r
# unload dplyr in case plyr is loaded in a subsequent script.
# always load plyr before dplyr.
detach(package:dplyr,  unload = TRUE)
```

