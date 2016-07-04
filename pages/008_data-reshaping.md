---
layout: page
title: "reshaping the data to long form"
---





Continue adding text and code to `01_calibr_data-reshaping.Rmd` file. 

Packages used in this tutorial 

- readr
- dplyr 
- tidyr 

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 

### preparing to reshape the data



![](../resources/images/text-icon.png)<!-- --> 

    # Preparing to reshape the data

    For analysis, the data set should be in long form, with every column a variable and every row an observation. 

    In a calibration, an observation is the set of conditions producing a single sensor reading in mV. For this data set, I propose the following variable names (column names) to characterize an observation:

    - observ (observation number)
    - cycle (cycle number)
    - test\_pt (test point number and direction)
    - input\_lb (applied reference force)
    - output\_mV (sensor readings)

Learning R Markdown:

- The "hyphen, space, text" markup in Rmd, e.g., `- observ`, creates an itemized list (bullet list). The list must start as if it were a new paragraph, with a line space between it and adjacent paragraphs.  
- To print an underscore in the Rmd prose we have to "escape" the character by writing `\_`. 

![](../resources/images/text-icon.png)<!-- --> 

    Each mV reading in a row is a separate observation. To reshape the data, we want to rewrite every mV reading to its own row, and characterize that observation by its particular cycle number (currently recorded in the column heading) and test condition (force and direction). 

    We begin this process by writing code to identify which of the columns include the character string, *cycle*, in their name. 

Of course, the point of having the code *find* the relevant columns instead of just subsetting the columns manually is to support reproducibility. Your data will change: the next set might have more cycles than this one; or a collaborator might change the order of the columns. Part of doing reproducible work is to anticipate reasonable differences between this data set and the next. 

![](../resources/images/code-icon.png)<!-- --> 


```r
# extract the indices of the column names that include "cycle"
all_col_names  <- colnames(data_received)
is_a_cycle_col <- grep('cycle', all_col_names, ignore.case = TRUE)
```

Learning R: 

- *colnames()* returns the data frame column names.
- *grep()* is a string pattern-matching function. Here, I use it to compare the string 'cycle' to the information in  `all_col_names`.
- I ignore case because the testing lab might send me future data with 'Cycle' capitalized. 
- For readable R code, align the assignment operator `<-` of sequential lines of code where feasible.

![](../resources/images/code-icon.png)<!-- --> 


```r
# the column indices
is_a_cycle_col
```

Learning R:

- Writing a variable on a line of its own, e.g., `is_a_cycle_col`, prints its value(s)
- `is_a_cycle_col` is a vector of integers. The number in brackets `[1]` is the index of the first element. 

### check yourself

Confer with a neighbor

1. What are the indices to the cycle columns? 

### reshaping data from wide to long

We're ready to reshape  `data_received` from wide form to long form. Long form is necessary for effective analysis. 

![](../resources/images/text-icon.png)<!-- -->

    # Reshaping data from wide to long

In this work, the cycle numbers (the original column headings) are  gathered in one new column and the mV readings (the original column  entries) are gathered in another new column. The *gather()* function from the *tidyr* package arranges each cycle and reading side by side in a new observation row. 

The new data frame has as many rows as there are observations in the original table. 

The columns "not gathered" remain, e.g., test_point, input_lb, with their entries copied into the new rows, maintaining the relationships described in the original data set.

![](../resources/images/code-icon.png)<!-- -->


```r
library(tidyr)
long_data <- data_received %>%
	gather(cycle, output_mV, is_a_cycle_col) 
```

Learning R:

- This code chunk could be read as, "Assign  `data_received` to a new data frame `long_data`, *then* gather the columns designated by `is_a_cycle_col` into two new columns, `cycle` and `output_mV`."
- the column names are gathered in the new `cycle` column 
- the mV readings are gathered in the new `output_mV`column

![](../resources/images/text-icon.png)<!-- -->

    Examine the result. 

![](../resources/images/code-icon.png)<!-- -->


```r
long_data # print it
str(long_data) # examine its structure
summary(long_data) # examine the summary statistics of each column
```

### check yourself

Confer with a neighbor.

1. The total number of observations is?
2. The total number of measured variables is? 

![](../resources/images/text-icon.png)<!-- -->

    This summary shows, first, that I have the columns I expected. 

    Second, all the NA values are in the mV readings column. These are not actually missing values. They represent superfluous rows, strictly artifacts of how the test lab organized their data table in the first place. We can safely delete these rows. 

![](../resources/images/code-icon.png)<!-- -->


```r
library(dplyr)
long_data <- long_data %>%
	filter(! output_mV %in% NA)
str(long_data)
```

Learning R:
 
- The *dplyr* package *filter()* function is a row operation that keeps all rows for which its argument is TRUE 
- `%in%` returns a logical vector indicating a match or not between the arguments on either side. Thus we are comparing the contents of the output\_mV column to NA
- The phrase `output_mV %in% NA` would return TRUE for all NA entries. But we want the reverse, to keep the rows that aren't NA. Thus we use the logical NOT (`!`) in front of the argument, i.e.,  `! output_mV %in% NA`
- *filter()* keeps the rows that are TRUE for "not NA" 

![](../resources/images/text-icon.png)<!-- -->

    It's a small enough data set, with 17 observations in 4 columns, that I can print the full set. 

![](../resources/images/code-icon.png)<!-- -->


```r
print(long_data)
```

Your output should look like this:


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

### write to file 

![](../resources/images/text-icon.png)<!-- -->

    Write the long-form data to file in the data directory.

![](../resources/images/code-icon.png)<!-- -->


```r
write_csv(long_data, "data/01_calibr_data-reshaping.csv")
```


Save and Knit this file. 


---
Back [first look at the data](007_first-look-at-data.html)<br>
Next [data tidying](009_data-tidying.html)

