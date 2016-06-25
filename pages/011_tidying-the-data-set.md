---
layout: page
title: tidying the data set 
tagline: load cell calibration 
---



### instructions

Install the following packages:

- *dplyr* 
- *tidyr* 
- *stringr* 




### Reshape the data from wide to long format



```r
library(readr)
wide_data <- read_csv('data/009_wide-data.csv')
```


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

# convert to long form, 
# create new column 'cycle' to gather column headings 
# create new column 'output_mV' to gather numerical readings
library(dplyr)
library(tidyr)
tidy_data <- wide_data %>%
	gather(cycle, output_mV, is_a_cycle_col) %>%
	as.data.frame()
print(tidy_data)
```

```
##    test_point input_lb   cycle output_mV
## 1        2 up      1.5 cycle_1        NA
## 2        3 up      2.5 cycle_1      51.1
## 3        4 up      3.5 cycle_1      70.4
## 4        5 up      4.5 cycle_1      88.8
## 5        4 dn      3.5 cycle_1      69.4
## 6        3 dn      2.5 cycle_1      49.5
## 7        2 dn      1.5 cycle_1      30.7
## 8        1 dn      0.5 cycle_1       8.7
## 9        2 up      1.5 cycle_2      29.9
## 10       3 up      2.5 cycle_2      49.4
## 11       4 up      3.5 cycle_2      70.0
## 12       5 up      4.5 cycle_2      91.6
## 13       4 dn      3.5 cycle_2      69.0
## 14       3 dn      2.5 cycle_2      50.1
## 15       2 dn      1.5 cycle_2      30.8
## 16       1 dn      0.5 cycle_2      10.9
## 17       2 up      1.5 cycle_3      30.2
## 18       3 up      2.5 cycle_3      49.7
## 19       4 up      3.5 cycle_3        NA
## 20       5 up      4.5 cycle_3        NA
## 21       4 dn      3.5 cycle_3        NA
## 22       3 dn      2.5 cycle_3        NA
## 23       2 dn      1.5 cycle_3        NA
## 24       1 dn      0.5 cycle_3        NA
```

Examine the structure of the data frame and find there are 2 character columns and 2 numerical columns. The two numerical columns are the data the are used for the calibration curve. 


```r
str(tidy_data)
```

```
## 'data.frame':	24 obs. of  4 variables:
##  $ test_point: chr  "2 up" "3 up" "4 up" "5 up" ...
##  $ input_lb  : num  1.5 2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 ...
##  $ cycle     : chr  "cycle_1" "cycle_1" "cycle_1" "cycle_1" ...
##  $ output_mV : num  NA 51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 ...
```

Now remove the test points for which there are no readings.


```r
tidy_data <- tidy_data %>%
	filter(!output_mV %in% NA)
print(tidy_data)
```

```
##    test_point input_lb   cycle output_mV
## 1        3 up      2.5 cycle_1      51.1
## 2        4 up      3.5 cycle_1      70.4
## 3        5 up      4.5 cycle_1      88.8
## 4        4 dn      3.5 cycle_1      69.4
## 5        3 dn      2.5 cycle_1      49.5
## 6        2 dn      1.5 cycle_1      30.7
## 7        1 dn      0.5 cycle_1       8.7
## 8        2 up      1.5 cycle_2      29.9
## 9        3 up      2.5 cycle_2      49.4
## 10       4 up      3.5 cycle_2      70.0
## 11       5 up      4.5 cycle_2      91.6
## 12       4 dn      3.5 cycle_2      69.0
## 13       3 dn      2.5 cycle_2      50.1
## 14       2 dn      1.5 cycle_2      30.8
## 15       1 dn      0.5 cycle_2      10.9
## 16       2 up      1.5 cycle_3      30.2
## 17       3 up      2.5 cycle_3      49.7
```

```r
str(tidy_data)
```

```
## 'data.frame':	17 obs. of  4 variables:
##  $ test_point: chr  "3 up" "4 up" "5 up" "4 dn" ...
##  $ input_lb  : num  2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 3.5 ...
##  $ cycle     : chr  "cycle_1" "cycle_1" "cycle_1" "cycle_1" ...
##  $ output_mV : num  51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 70 ...
```


### Add the observation number

The data are in the order observed, so we can add a column to list the observation number.


```r
tidy_data$observ <- row.names(tidy_data)
print(tidy_data)
```

```
##    test_point input_lb   cycle output_mV observ
## 1        3 up      2.5 cycle_1      51.1      1
## 2        4 up      3.5 cycle_1      70.4      2
## 3        5 up      4.5 cycle_1      88.8      3
## 4        4 dn      3.5 cycle_1      69.4      4
## 5        3 dn      2.5 cycle_1      49.5      5
## 6        2 dn      1.5 cycle_1      30.7      6
## 7        1 dn      0.5 cycle_1       8.7      7
## 8        2 up      1.5 cycle_2      29.9      8
## 9        3 up      2.5 cycle_2      49.4      9
## 10       4 up      3.5 cycle_2      70.0     10
## 11       5 up      4.5 cycle_2      91.6     11
## 12       4 dn      3.5 cycle_2      69.0     12
## 13       3 dn      2.5 cycle_2      50.1     13
## 14       2 dn      1.5 cycle_2      30.8     14
## 15       1 dn      0.5 cycle_2      10.9     15
## 16       2 up      1.5 cycle_3      30.2     16
## 17       3 up      2.5 cycle_3      49.7     17
```

```r
str(tidy_data)
```

```
## 'data.frame':	17 obs. of  5 variables:
##  $ test_point: chr  "3 up" "4 up" "5 up" "4 dn" ...
##  $ input_lb  : num  2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 3.5 ...
##  $ cycle     : chr  "cycle_1" "cycle_1" "cycle_1" "cycle_1" ...
##  $ output_mV : num  51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 70 ...
##  $ observ    : chr  "1" "2" "3" "4" ...
```

### Split the string variables

The *test_point* variable is a character string that can be split to form *test_point* and *direction* columns.


```r
library(stringr)
split_column <- str_split_fixed(tidy_data$test_point, pattern = ' ', 2)
tidy_data <- tidy_data %>%
	mutate(N = split_column[ , 1]) %>%
	mutate(direction = split_column[ , 2])
str(tidy_data)
```

```
## 'data.frame':	17 obs. of  7 variables:
##  $ test_point: chr  "3 up" "4 up" "5 up" "4 dn" ...
##  $ input_lb  : num  2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 3.5 ...
##  $ cycle     : chr  "cycle_1" "cycle_1" "cycle_1" "cycle_1" ...
##  $ output_mV : num  51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 70 ...
##  $ observ    : chr  "1" "2" "3" "4" ...
##  $ N         : chr  "3" "4" "5" "4" ...
##  $ direction : chr  "up" "up" "up" "dn" ...
```

Remove the original *test_point* column and rename *N* as *test_point*


```r
tidy_data <- tidy_data %>%
	select(-test_point) %>%
	rename(test_point = N)
str(tidy_data)
```

```
## 'data.frame':	17 obs. of  6 variables:
##  $ input_lb  : num  2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 3.5 ...
##  $ cycle     : chr  "cycle_1" "cycle_1" "cycle_1" "cycle_1" ...
##  $ output_mV : num  51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 70 ...
##  $ observ    : chr  "1" "2" "3" "4" ...
##  $ test_point: chr  "3" "4" "5" "4" ...
##  $ direction : chr  "up" "up" "up" "dn" ...
```

Similarly, split the cycle string and keep only the cycle number, N. 


```r
split_column <- str_split_fixed(tidy_data$cycle, pattern = '_', 2)
tidy_data$cycle <- split_column[ , 2]

# arrange the column order
tidy_data <- tidy_data %>%
	select(observ, cycle, test_point, direction, input_lb, output_mV)
print(tidy_data, row.names = FALSE)
```

```
##  observ cycle test_point direction input_lb output_mV
##       1     1          3        up      2.5      51.1
##       2     1          4        up      3.5      70.4
##       3     1          5        up      4.5      88.8
##       4     1          4        dn      3.5      69.4
##       5     1          3        dn      2.5      49.5
##       6     1          2        dn      1.5      30.7
##       7     1          1        dn      0.5       8.7
##       8     2          2        up      1.5      29.9
##       9     2          3        up      2.5      49.4
##      10     2          4        up      3.5      70.0
##      11     2          5        up      4.5      91.6
##      12     2          4        dn      3.5      69.0
##      13     2          3        dn      2.5      50.1
##      14     2          2        dn      1.5      30.8
##      15     2          1        dn      0.5      10.9
##      16     3          2        up      1.5      30.2
##      17     3          3        up      2.5      49.7
```

```r
str(tidy_data)
```

```
## 'data.frame':	17 obs. of  6 variables:
##  $ observ    : chr  "1" "2" "3" "4" ...
##  $ cycle     : chr  "1" "1" "1" "1" ...
##  $ test_point: chr  "3" "4" "5" "4" ...
##  $ direction : chr  "up" "up" "up" "dn" ...
##  $ input_lb  : num  2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 3.5 ...
##  $ output_mV : num  51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 70 ...
```


### Convert numerical strings to integers

The first three columns (observ, cycle, and test_point) are characters because they were split from character strings. For analysis, these may be better if converted to integers. 


```r
tidy_data <- tidy_data %>%
	mutate(observ = as.integer(observ)) %>%
	mutate(cycle = as.integer(cycle)) %>%
	mutate(test_point = as.integer(test_point))
str(tidy_data)
```

```
## 'data.frame':	17 obs. of  6 variables:
##  $ observ    : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ cycle     : int  1 1 1 1 1 1 1 2 2 2 ...
##  $ test_point: int  3 4 5 4 3 2 1 2 3 4 ...
##  $ direction : chr  "up" "up" "up" "dn" ...
##  $ input_lb  : num  2.5 3.5 4.5 3.5 2.5 1.5 0.5 1.5 2.5 3.5 ...
##  $ output_mV : num  51.1 70.4 88.8 69.4 49.5 30.7 8.7 29.9 49.4 70 ...
```

### Save the tidy data for analysis

These data are saved in CSV form for calibration analysis. 


```r
write_csv(tidy_data, 'data/008_tidy-data.csv')
```
 

```r
# unload dplyr in case plyr is loaded in a subsequent script.
# always load plyr before dplyr.
detach(package:dplyr,  unload = TRUE)
```

