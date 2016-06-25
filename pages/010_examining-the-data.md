---
layout: page
title: examining the data 
tagline: load cell calibration 
---



### instructions

In the pre-workshop homework you installed the *readr* library. If not, the instructions are repeated here: 

- In RStudio, lower right pane, select Packages -> Install 
- In the dialog box, type `readr` 
- Check the box to install dependencies 
- Select Install 

In your Rmd file 

- Add a new section heading `## Examine the data` 
- add code (shown boxed) in code chunks 

Code results (which should also show up in your Viewer pane) are shown boxed with a double hash tag 


### examine the data 

Use the *readr* package *read_csv()* function to bring the calibration data (the data you downloaded earlier) into the R workspace. In a code chunk, add 


```r
library(readr)
wide_data <- read_csv('data/009_wide-data.csv')
```


- *library()* loads a package so we can use its functions 
- *read_csv()* reads a CSV file 

> Examine the data: 

- *str()* is an R function that describes the structure of its argument


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

- *dim()* is an R function that returns the row by column dimensions of the data frame


```r
dim(wide_data)
```

```
## [1] 8 5
```

- *names()* is an R function that returns the columns headings in a data frame


```r
names(wide_data)
```

```
## [1] "test_point" "input_lb"   "cycle_1"    "cycle_2"    "cycle_3"
```

- *head()* and *tail()* are R functions for examining the first *n* rows and the last *n* rows of a data frame. `3L` is R-syntax declaring that 3 is an integer, not a floating-point number.


```r
head(wide_data, n = 3L)
```

```
## Source: local data frame [3 x 5]
## 
##   test_point input_lb cycle_1 cycle_2 cycle_3
##        (chr)    (dbl)   (dbl)   (dbl)   (dbl)
## 1       2 up      1.5      NA    29.9    30.2
## 2       3 up      2.5    51.1    49.4    49.7
## 3       4 up      3.5    70.4    70.0      NA
```

```r
tail(wide_data, n = 3L)
```

```
## Source: local data frame [3 x 5]
## 
##   test_point input_lb cycle_1 cycle_2 cycle_3
##        (chr)    (dbl)   (dbl)   (dbl)   (dbl)
## 1       3 dn      2.5    49.5    50.1      NA
## 2       2 dn      1.5    30.7    30.8      NA
## 3       1 dn      0.5     8.7    10.9      NA
```

- *summary()* provides the descriptive statistics of each column 


```r
summary(wide_data)
```

```
##   test_point           input_lb      cycle_1         cycle_2     
##  Length:8           Min.   :0.5   Min.   : 8.70   Min.   :10.90  
##  Class :character   1st Qu.:1.5   1st Qu.:40.10   1st Qu.:30.57  
##  Mode  :character   Median :2.5   Median :51.10   Median :49.75  
##                     Mean   :2.5   Mean   :52.66   Mean   :50.21  
##                     3rd Qu.:3.5   3rd Qu.:69.90   3rd Qu.:69.25  
##                     Max.   :4.5   Max.   :88.80   Max.   :91.60  
##                                   NA's   :1                      
##     cycle_3     
##  Min.   :30.20  
##  1st Qu.:35.08  
##  Median :39.95  
##  Mean   :39.95  
##  3rd Qu.:44.83  
##  Max.   :49.70  
##  NA's   :6
```

- the data set is small enough in this case that we can print the full set to the output document using *print()*  


```r
print(wide_data)
```

```
## Source: local data frame [8 x 5]
## 
##   test_point input_lb cycle_1 cycle_2 cycle_3
##        (chr)    (dbl)   (dbl)   (dbl)   (dbl)
## 1       2 up      1.5      NA    29.9    30.2
## 2       3 up      2.5    51.1    49.4    49.7
## 3       4 up      3.5    70.4    70.0      NA
## 4       5 up      4.5    88.8    91.6      NA
## 5       4 dn      3.5    69.4    69.0      NA
## 6       3 dn      2.5    49.5    50.1      NA
## 7       2 dn      1.5    30.7    30.8      NA
## 8       1 dn      0.5     8.7    10.9      NA
```

> We see from this initial exploration that the data consist of 8 measurements per cycle with 3 cycles. Some data are missing from some cycles (indicated by NA)  which is consistent with the ANSI/ISA standard by which the data were obtained.
> 
> 
> The data are in *wide format* making them easy to read but difficult for analysis. Reshaping the data from wide format to long format is the next topic.

A reminder, in your scripts, you should: 

- Type (or copy and paste) the R code chunks in full
- Type (or copy and paste) enough of the prose to explain the analysis.
