---
layout: page
title: examining the data 
---

### read the data file 

If you haven't already, install the *readr* package from RStudio using *Packages -> Install -> readr*. 

Insert a code chunk and add this R code: 




```r
# match the knitr root directory to the project working directory
library(knitr) 
opts_knit$set(root.dir = '../')
```

Add this explanatory prose

```
Input the data file that was provided. 
``` 
 
followed by the next code chunk with this R script: 


```r
# assign the data to a variable name
library(readr)
wide_data <- read_csv('data/009_wide-data.csv')
```

Notes on the script: 

- `# comment` a hash tag in R denotes a comment 
- `library()` loads a package so we can use its functions 
- `<-` is the R assignment operator 
- `read_csv()` the path to the CSV file is relative to the project working directory  


### structure 

Add prose

```
Examine the data object's structure.
```

followed by a code chunk with this R code: 


```r
str(wide_data)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	8 obs. of  5 variables:
##  $ test_point: chr  "2 up" "3 up" "4 up" "5 up" ...
##  $ input_lb  : num  1.5 2.5 3.5 4.5 3.5 2.5 1.5 0.5
##  $ cycle_1   : num  NA 51.1 70.4 88.8 69.4 49.5 30.7 8.7
##  $ cycle_2   : num  29.9 49.4 70 91.6 69 50.1 30.8 10.9
##  $ cycle_3   : num  30.2 49.7 NA NA NA NA NA NA
```

Add prose:

```
The data frame has 8 observations (rows) of 5 variables (columns). Several columns are separate test cycles, indicating we have a "wide" rather than a "long" data set. 

The column headings tell us that the applied force is in pounds (lb). From a conversation with the test lab, we know the readings are in mV. 
```

Notes on the script: 

- `str()` returns the structure of the R object. Whe we read a csv file using `read_csv()` the object typically belongs to three R *classes*: tbl_df, tbl, and data.frame. The data frame class is the one we will use regularly. 


