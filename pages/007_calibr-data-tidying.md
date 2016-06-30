---
layout: page
title: tidying data
---







How to use the tutorial 

- <img src="../resources/images/insert-text-icon.png" width="20" /> : transcribe the block of text into your script verbatim. Copy and paste is OK. 
- <img src="../resources/images/insert-code-chunk-icon.png" width="20" /> : insert a new code chunk then transcribe the R code from the box into the chunk.  Copy and paste is OK.  
- Save and Knit after each addition. 

Packages we use in the tutorial have to be installed (just once) before we can access their functions. For example, if you installed the *readr* package earlier, you don't have to install it again. Install these packages for this tutorial: 

- readr 
- tidyr 
- dplyr 
- stringr 

Sometimes when I show you a bit of R code I also show you the output the code produces.  Do not copy the output to your script. Code output is boxed and has two hash tags on every line, for example: 




```
## Source: local data frame [3 x 5]
## 
##   test_point input_lb cycle_1 cycle_2 cycle_3
##        <chr>    <dbl>   <dbl>   <dbl>   <dbl>
## 1       2 up      1.5      NA    29.9    30.2
## 2       3 up      2.5    51.1    49.4    49.7
## 3       4 up      3.5    70.4    70.0      NA
```






# introduction  

Our first paragraph establishes the context for the analysis.

<img src="../resources/images/insert-text-icon.png" width="20" /> --- Reminder: this text is copied verbatim.

```
# Introduction

Calibration test data for an Omega LCL-005 (0--5 lb) load cell (a force sensor) has been provided by the test lab. The goal of this analysis is to determine the calibration equation and estimate the sensor accuracy. 
```

- In Rmd, the single hash tag `#` denotes a level-1 heading. 

<img src="../resources/images/insert-text-icon.png" width="20" />
<pre><code>The lab sent an image of the test setup. A known weight (lb) is attached to the eye hook and the load cell bridge produces an output signal (mV). 

<code>```</code>{r fig.cap = 'Figure 1. Load cell calibration test setup', dpi = 300}
knitr::include_graphics("../resources/load-cell-setup-786x989px.png")
<code>```</code>
</code></pre>

- The code chunk option `fig.cap` adds a caption;  `dpi` scales the size of the image. (Image width = width_pixels / dpi.)
- The R syntax `knitr::include_graphics()` tells R to run the *include_graphics()* function from the *knitr* package
- *include_graphics()* imports the image you downloaded earlier to your `resources` directory. 
- The file path is in quotes. `../` tells *knitr* to start one directory level up (the project-level directory), down to `resources/`, and then to the file name. (Even though we've assigned the *knitr* root-directory one level up, a quirk of knitr requires us to use this relative path up.)

<div class="figure">
<img src="../resources/load-cell-setup-786x989px.png" alt="Figure 1. Load cell calibration test setup" width="302" />
<p class="caption">Figure 1. Load cell calibration test setup</p>
</div>


# examine the data 

<img src="../resources/images/insert-text-icon.png" width="20" /> --- Start a new section.

```
# Examine the data 
```

 <img src="../resources/images/insert-code-chunk-icon.png" width="20" /> --- Reminder, this R code goes inside a code chunk.
 

```r
# read the data set as received
library(readr)
data_received <- read_csv('../data/007_wide-data.csv')
```

- This code chunk reads the data you downloaded and saved in the `data` directory. 

This is a good moment to remind you that you are learning two syntaxes: R Markdown (Rmd) for reporting and R for computing. The single hash tag # is interpreted differently in the two syntaxes: 

- In R, the single hash tag denotes a comment.
- In Rmd, the single hash tag denotes a level-1 heading. 

<img src="../resources/images/insert-text-icon.png" width="20" />  

```
First look at the data structure.
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" /> 


```r
str(data_received)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	8 obs. of  5 variables:
##  $ test_point: chr  "2 up" "3 up" "4 up" "5 up" ...
##  $ input_lb  : num  1.5 2.5 3.5 4.5 3.5 2.5 1.5 0.5
##  $ cycle_1   : num  NA 51.1 70.4 88.8 69.4 49.5 30.7 8.7
##  $ cycle_2   : num  29.9 49.4 70 91.6 69 50.1 30.8 10.9
##  $ cycle_3   : num  30.2 49.7 NA NA NA NA NA NA
```

- *str()* displays the structure of an R object 

<img src="../resources/images/insert-text-icon.png" width="20" /> 

```
As expected, *read_csv()* produced a data frame. All columns are numerical except the *test_point* column that shows test condition number and a direction.
```
- Asterisks around a word or phrase are the Rmd syntax for italics.

<img src="../resources/images/insert-text-icon.png" width="20" />  

```
Look at the first few rows of the data set. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" /> 


```r
head(data_received)
```

- *head()* displays the first few rows of the data set. 


<img src="../resources/images/insert-text-icon.png" width="20" /> 

```
The data set has mV readings in several columns, designated *cycle_1*, *cycle_2*, etc. Thus, the data are in wide form and will have to be reshaped to long form for analysis. 

I see some NA values, which is consistent with the calibration test protocol. A summary of the numerical columns might be useful.
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />  


```r
# summary-stats except column 1
summary(data_received[ , -1])
```

- *summary()* produces a statistical summary of each column in the data frame. 
- In R, square brackets `[]` subset the data frame. Here the subset `[ , -1]` tells R to keep all rows and omit the first column when evaluating the *summary()* function. 
 
<img src="../resources/images/insert-text-icon.png" width="20" />
 
```
For all cycles, the mean, min, and max  readings (mV) are similar. We have NA in the first and last cycles only, as expected.  
```




# reshape the data to long form

<img src="../resources/images/insert-text-icon.png" width="20" /> 

```
# Reshape the data to long form

For analysis, the data set should be in long form, with every column a variable and every row an observation. I've selected these variable names: 

- observ (observation number)
- cycle (cycle number)
- test\_pt (test point number and direction)
- input\_lb (applied reference force)
- output\_mV (sensor readings)
```

- To print an underscore in the prose we have to "escape" the character by writing `\_`. 
 

<img src="../resources/images/insert-text-icon.png" width="20" /> 

```
In this case, data reshaping is all about gathering the data in the *cycle* columns, so first we determine which of the column names include *cycle*.
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" /> 


```r
# indices of cycle columns (listing the mV data)
is_a_cycle_col <- grep('cycle', colnames(data_received), ignore.case = TRUE)

# the column indices
is_a_cycle_col
```

```
## [1] 3 4 5
```

- *colnames()* returns the data frame column names.
- *grep()* is a string pattern-matching function. Here, I use it to compare the string 'cycle' to the column names, ignoring case---a preventative measure in case the testing lab happens to send me data in the future with 'Cycle' capitalized. 
- Writing an object name on a line of its own, e.g., `is_a_cycle_col`,  prints the output. For example, this output tells me that columns 3, 4, 5 have "cycle" in their columns names. 


<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
# look at the the column names at those locations
colnames(data_received)[is_a_cycle_col]
```

```
## [1] "cycle_1" "cycle_2" "cycle_3"
```

- I subset the column names using `[]` 
- The output confirms that I have the columns I want. 


To reshape these columns, I use the *tidyr* package *gather()* function to create two new data columns: 

-  a new column called *cycle* for gathering the existing cycle-column-names  
- a new column called *output_mV* for gathering the mV readings in those columns 

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
library(tidyr)
long_data <- data_received %>%
	gather(cycle, output_mV, is_a_cycle_col) 
```

- The pipe operator `%>%` can be thought of as the adverb "then". Thus, this code chunk could be read as "Assign the `data_received` data frame to a new object named `long_data`, *then* gather the columns designated by `is_a_cycle_col` into two new columns named `cycle` (for the old column names) and `output_mV` (for the old column data)."

<img src="../resources/images/insert-text-icon.png" width="20" />

```
Examine the result. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
long_data # print it
str(long_data) # structure
summary(long_data) # summary of column stats
```



```
##   test_point           input_lb      cycle             output_mV   
##  Length:24          Min.   :0.5   Length:24          Min.   : 8.7  
##  Class :character   1st Qu.:1.5   Class :character   1st Qu.:30.7  
##  Mode  :character   Median :2.5   Mode  :character   Median :49.7  
##                     Mean   :2.5                      Mean   :50.0  
##                     3rd Qu.:3.5                      3rd Qu.:69.4  
##                     Max.   :4.5                      Max.   :91.6  
##                                                      NA's   :7
```


<img src="../resources/images/insert-text-icon.png" width="20" />

```
This summary shows that all the NA values are in the mV readings column. These are not actually missing values. They represent superfluous rows, strictly artifacts of how the test lab organized their data table in the first place. We can safely delete these rows. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
library(dplyr)
long_data <- long_data %>%
	filter(! output_mV %in% NA)
str(long_data)
```

- The *dplyr* package *filter()* function is a row operation that keeps all rows for which its argument is TRUE 
- `%in%` returns a logical vector indicating a match or not between the arguments on either side 
- If we had written `output_mV %in% NA`, R would return TRUE for all NA entries. But we want the reverse, to keep the NOT NA rows. Thus we use the logical NOT `!` in front of the argument `! output_mV %in% NA`, converting logical FALSE to TRUE (and TRUE to FALSE), thereby keeping the meaningful rows and omitting the NA rows. 

<img src="../resources/images/insert-text-icon.png" width="20" />

```
It's a small enough data set, with 17 observations in 4 columns, that I can print the full set. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
print(long_data)
```

```
## Source: local data frame [17 x 4]
## 
##    test_point input_lb   cycle output_mV
##         <chr>    <dbl>   <chr>     <dbl>
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

- Your output should look like the outut printed above. 





# add observation numbers


<img src="../resources/images/insert-text-icon.png" width="20" />

```
# add observation numbers

The test points are in the order in which the data were acquired (consistent with the ANSI/ISA standard). So the observation number is the same as the row number. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
# add a new column
long_data[ , 'observ'] <- 1:nrow(long_data)
head(long_data)
```

- Here, the subset brackets `[ , 'observ']` add a new column 
- *nrow()* returns the number of rows in the data frame
- The `:` operator creates a sequence 





# simplify the cycle number

<img src="../resources/images/insert-text-icon.png" width="20" />

```
# simplify the cycle number

The *cycle* data are strings, *cycle_1*, *cycle_2*, etc. It might be useful to replace these entries with an integer for the cycle number. 

First, I separate the *cycle* column into two parts using the underscore in the data as the separation pattern. 
```

####################################################

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
library(stringr)
cycle_column  <- long_data %>%
	select(cycle)
split_columns <- str_split_fixed(cycle_column, n = 2, pattern = '_')
```

- *stringr* is a package for manipulating character strings
- *string_split_fixed()* is a function that splits our `'cycle'` string column into *n* pieces, using the underscore as the pattern to split on

<img src="../resources/images/insert-text-icon.png" width="20" />

```
Investigate the split_columns object.
```


<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
class(split_columns)
```

- *class()* returns that the `split_columns` object is an R matrix, so we can subset it using `[]` notation
- we will want to keep the second column with the number




<img src="../resources/images/insert-text-icon.png" width="20" />

```
I keep only the 2nd column (the cycle number), convert it to an integer (it's a character), and assign it as a new column *cycle_no* in the data frame. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
long_data$cycle_no <- as.integer(split_columns[ , 2])
```

```
## Warning: NAs introduced by coercion
```

```r
head(long_data)
```

```
## Source: local data frame [6 x 6]
## 
##   test_point input_lb   cycle output_mV observ cycle_no
##        <chr>    <dbl>   <chr>     <dbl>  <int>    <int>
## 1       3 up      2.5 cycle_1      51.1      1       NA
## 2       4 up      3.5 cycle_1      70.4      2       NA
## 3       5 up      4.5 cycle_1      88.8      3       NA
## 4       4 dn      3.5 cycle_1      69.4      4       NA
## 5       3 dn      2.5 cycle_1      49.5      5       NA
## 6       2 dn      1.5 cycle_1      30.7      6       NA
```

```r
tail(long_data)
```

```
## Source: local data frame [6 x 6]
## 
##   test_point input_lb   cycle output_mV observ cycle_no
##        <chr>    <dbl>   <chr>     <dbl>  <int>    <int>
## 1       4 dn      3.5 cycle_2      69.0     12       NA
## 2       3 dn      2.5 cycle_2      50.1     13       NA
## 3       2 dn      1.5 cycle_2      30.8     14       NA
## 4       1 dn      0.5 cycle_2      10.9     15       NA
## 5       2 up      1.5 cycle_3      30.2     16       NA
## 6       3 up      2.5 cycle_3      49.7     17       NA
```

<img src="../resources/images/insert-text-icon.png" width="20" />

```
Spot checking with *head()* and *tail()*, I confirm that the new cycle_no column agrees with the original cycle column data. 
```




# final touches

<img src="../resources/images/insert-text-icon.png" width="20" />

```
The last steps in tidying this data set are to delete the original  *cycle* column and reuse the name for the new cycle column, to shorten the *test_point* column name, and to rearrange columns in a logical order. 
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
tidy_data <- long_data %>%
	select(-cycle) %>%
	rename('cycle' = cycle_no) %>%
	rename('test_pt' = test_point) %>%
	select(observ, cycle, test_pt, input_lb, output_mV)
print(tidy_data)
```

```
## Source: local data frame [17 x 5]
## 
##    observ cycle test_pt input_lb output_mV
##     <int> <int>   <chr>    <dbl>     <dbl>
## 1       1    NA    3 up      2.5      51.1
## 2       2    NA    4 up      3.5      70.4
## 3       3    NA    5 up      4.5      88.8
## 4       4    NA    4 dn      3.5      69.4
## 5       5    NA    3 dn      2.5      49.5
## 6       6    NA    2 dn      1.5      30.7
## 7       7    NA    1 dn      0.5       8.7
## 8       8    NA    2 up      1.5      29.9
## 9       9    NA    3 up      2.5      49.4
## 10     10    NA    4 up      3.5      70.0
## 11     11    NA    5 up      4.5      91.6
## 12     12    NA    4 dn      3.5      69.0
## 13     13    NA    3 dn      2.5      50.1
## 14     14    NA    2 dn      1.5      30.8
## 15     15    NA    1 dn      0.5      10.9
## 16     16    NA    2 up      1.5      30.2
## 17     17    NA    3 up      2.5      49.7
```


<img src="../resources/images/insert-text-icon.png" width="20" />

```
Write the tidy data to file in the data directory.
```

<img src="../resources/images/insert-code-chunk-icon.png" width="20" />


```r
write_csv(tidy_data, "../data/01_calibr_data-tidying.csv")
```







<br><br><br>
