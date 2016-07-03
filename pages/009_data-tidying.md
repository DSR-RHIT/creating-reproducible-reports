---
layout: page
title: "data tidying"
---





Continue adding text and code to `01_calibr_data.Rmd` file. 

Packages used in this tutorial  

- dplyr 
- tidyr 
- readr

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 


### add a column of observation numbers

![](../resources/images/code-icon.png)<!-- -->


```r
# read the long-form data file we saved in the previous step 
library(readr)
tidy_data <- read_csv('data/01_calibr_long-form-data.csv')
```

![](../resources/images/text-icon.png)<!-- -->

    # Add a column of observation numbers

    The test points are in the order in which the data were acquired (consistent with the ANSI/ISA standard). So the observation number is the same as the row number. 

I'm not going to use the default row names as observation numbers because they are character strings, not integers. Instead, I construct an integer vector and assign it to a new column in the data frame. 

![](../resources/images/code-icon.png)<!-- -->


```r
library(dplyr)
# observation numbers are a sequence of integers, from 1 to the number of rows
nrow_in_tidy_data <- nrow(tidy_data)
tidy_data <- tidy_data %>%
	mutate(observ = 1:nrow_in_tidy_data)
head(tidy_data)
```

Learning R:

- *nrow()* returns the number of rows in the data frame
- *mutate()* creates a new column called `observ`  
- The `:` operator creates a sequence 

### simplify the cycle number

![](../resources/images/text-icon.png)<!-- -->

    # simplify the cycle number

    The *cycle* data are strings, *cycle_1*, *cycle_2*, etc., from the column headings in the original data set. It might be useful omit the word "cycle" altogether and replace the data with an integer number for the cycle. 

    First, I separate the *cycle* column into two parts using the underscore in the data as the separation pattern. 

![](../resources/images/code-icon.png)<!-- -->


```r
library(tidyr)
tidy_data  <- tidy_data %>%
	separate(cycle, into = c('prefix', 'cycle'), sep = '_')
```

Learning R:

- *separate()* is a *tidyr* function that turns one column of strings into multiple columns of strings 
- `into` assigns the new column names
- `sep` assigns the character separator
- `c()` operator *combines* values into a vector

![](../resources/images/text-icon.png)<!-- -->

    Examine the separated columns.

![](../resources/images/code-icon.png)<!-- -->


```r
head(tidy_data)
```

![](../resources/images/text-icon.png)<!-- -->

    I can delete the new prefix column and I'll convert the cycle column from a character to an integer. 

![](../resources/images/code-icon.png)<!-- -->


```r
tidy_data <- tidy_data %>%
	select(-prefix) %>%
	mutate(cycle = as.integer(cycle))
```

- This code chunk could be read as "Overwrite `tidy_data` with `tidy_data`, then keep all columns except `prefix`, then convert the `cycle` column to integers and assign the results to the `cycle` column, overwriting the previous column."

![](../resources/images/code-icon.png)<!-- -->


```r
# Examine the results
head(tidy_data)
tail(tidy_data)
```

![](../resources/images/text-icon.png)<!-- -->

    Spot checking with *head()* and *tail()*, I confirm that the new cycle column is as expected. 

### final touches

![](../resources/images/text-icon.png)<!-- --> 

    The last steps in tidying this data set are to shorten the *test_point* column name and to rearrange columns in a logical order. 

![](../resources/images/code-icon.png)<!-- -->


```r
tidy_data <- tidy_data %>%
	select(observ, cycle, test_pt = test_point, input_lb, output_mV)
print(tidy_data)
```

Learning R:

- *select()* orders the columns from left to right in the order you list them
- `test_pt = test_point` inside the *select()* function renames the existing column as in `new_name = old_name`

![](../resources/images/text-icon.png)<!-- -->

    Write the tidy data to file in the data directory.

![](../resources/images/code-icon.png)<!-- -->


```r
write_csv(tidy_data, "data/01_calibr_data-tidying.csv")
```

Learning R:

 - the first argument in *write_csv()* is the data frame
 - the path shown will save to the `data` directory with the CSV filename shown 

In the next step, we perform the calibration analysis.  

---
Back [data reshaping](pages/008_data-reshaping.html)<br>
Next [linear regression](pagses/010_linear-regression.html)
