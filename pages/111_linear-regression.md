---
layout: page
title: "linear regression"
---





Packages used in this tutorial  

- readr
- dplyr

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 

### open a new Rmd script

We start a new Rmd script to perform the linear regression analysis and save the results to file.  

- Open a new Rmd file, and name it `03_calibr_regression.Rmd`
- Start the new script with the same YAML header as the previous script
- Change the title to `"Load-cell calibration --- linear regression"`
- Inset the same code chunk for the knitr setup 

Knowing the packages we'll be using, we can load them right away, near the top of the file.

![](../resources/images/code-icon.png)<!-- -->


```r
# load packages
library(readr)
library(dplyr)
```

### perform the linear regression 

![](../resources/images/text-icon.png)<!-- -->

    # Perform the linear regression 

![](../resources/images/code-icon.png)<!-- -->


```r
# read the tidy data
calibr_data <- read_csv("data/02_calibr_data-tidying.csv")
head(calibr_data)
```

![](../resources/images/text-icon.png)<!-- -->

    A linear regression relating the mV readings to the input force  produces the results we need to report the calibration equation and the sensor accuracy. 

    - `input_lb` is the independent variable (*x*) 
    - `output_mV` is the dependent variable (*y*) 

Learning Rmd:

- A pair of single back ticks typeset the word like computer code 
- A pair of asterisks typeset the word in italics 

![](../resources/images/text-icon.png)<!-- -->

    The *lm()* function creates the regression results we need:  

    - slope and intercept of the linear regression
    - the fitted y-values 
    - the residuals 

![](../resources/images/code-icon.png)<!-- -->


```r
# perform the regression
regr_results <- lm(output_mV ~ input_lb, data = calibr_data)
```

Learning R:

- The linear model function has the form `lm(y ~ x, data = data_frame)`, that is, "$y$ as a function of $x$," where $y$ and $x$ are variables (column names) in the data frame denoted by `data = data_frame`
- The argument `y ~ x` is a *formula*, an R object class 
- Learn more by typing `?lm` in your Console

### extract relevant results 

![](../resources/images/text-icon.png)<!-- -->

    # Extract relevant results 
    
    Look at the attributes of the `lm()` results. 

![](../resources/images/code-icon.png)<!-- -->


```r
attributes(regr_results)
```

Learn R:

- `attributes(regr_results)` retrieves meta-data stored with the object `regr_results` 

![](../resources/images/text-icon.png)<!-- -->

    The named variables we need from this list are `[1] coefficients`, `[2] residuals`, and `[5] fitted.values`. Examining the structure of these three variables yields

![](../resources/images/code-icon.png)<!-- -->


```r
str(regr_results[c(1, 2, 5)])
```

### check yourself

Confer with a neighbor.

1. How many elements in the `coefficients` vector?
2. What is the numeric value of the regression intercept? of the slope? 
3. How many elements in the `residuals` vector? 

For reasons unknown, the default R output of `coefficients` labels the slope of the regression using the name of the x-variable. 

![](../resources/images/text-icon.png)<!-- -->

    Coefficients has 2 elements; the first is the intercept, the second is the slope. Residuals and fitted values are vectors the same length as the data set, as expected. 
    
    Extract the variables we need: `intercept`, `slope`, `fitted.values`, and `residuals`.  

![](../resources/images/code-icon.png)<!-- -->


```r
intercept <- regr_results$coefficients[1]
slope     <- regr_results$coefficients[2]
y_fit     <- regr_results$fitted.values
residuals <- regr_results$residuals
```

Learn R.

- We can subset a named value from a list using `$` syntax, e.g.,  `regr_results$fitted.values` starts with the `regr_results` list and extracts the the `fitted.values` vector. 
- In the case of the coefficients, we further subset the vector using `[]` notation, selecting `[1]` for the intecept and `[2]` for the slope. 

### determine sensor accuracy

![](../resources/images/text-icon.png)<!-- -->

    # Determine sensor accuracy
    
    The ANSI/ISA calibration standard defines accuracy as the maximum positive and maximum negative residual. 

![](../resources/images/code-icon.png)<!-- -->


```r
# determine accuracy in mV
max_resid <- max(residuals)
min_resid <- min(residuals)
```

- `max()` and `min()` are R functions that do the obvious

![](../resources/images/text-icon.png)<!-- -->

    In percentage form, accuracy is a percent of output span. The standard defines output span as the difference between the max and min y-fitted values. 

![](../resources/images/code-icon.png)<!-- -->


```r
output_span <- max(y_fit) - min(y_fit)
acc_plus    <- max_resid / output_span * 100
acc_minus   <- min_resid / output_span * 100
```

R coding practice:

- Place a space before and after math operators, e.g., `+`, `-`, `/`, `*`, etc. for readability

![](../resources/images/text-icon.png)<!-- -->

    Display the values. 

![](../resources/images/code-icon.png)<!-- -->


```r
acc_plus
acc_minus
```

![](../resources/images/text-icon.png)<!-- -->

    Reported accuracy is the absolute value of the largest of these two values.   

![](../resources/images/code-icon.png)<!-- -->


```r
accuracy <- max(abs(c(acc_plus, acc_minus)))
```

### check yourself

Confer with a neighbor.

1. What is your sensor accuracy in percent?

### collect results 

![](../resources/images/text-icon.png)<!-- -->

    # Collect results 
    
    I'd also like to record the input range.

![](../resources/images/code-icon.png)<!-- -->


```r
x <- calibr_data[ , 'input_lb']
input_range <- max(x) - min(x)
```

Learn R.

- We use `[row, col]` notation to subset an object. Here we select all rows (the row position is left blank) and only one column (named `input_lb`). 

![](../resources/images/text-icon.png)<!-- -->

    And I can collect these results in a data frame.

![](../resources/images/code-icon.png)<!-- -->


```r
# create a data frame for printing a table of results
options(digits = 2)
item <- c('input_range', 
          'output_span', 
          'slope', 
          'intercept', 
          'max_resid', 
          'min_resid', 
          'accuracy')
value  <- c(input_range, 
           output_span, 
           slope, 
           intercept, 
           max_resid, 
           min_resid, 
           accuracy)
units  <- c('lb', 
          'mV', 
          'mV/lb', 
          'mV', 
          'mV', 
          'mV', 
          '%')

calibr_results <- data_frame(item, value, units)
calibr_results
```

Coding practice

- In this code chunk, I've deliberately placed each element of a vector on its own line to help me keep them on order as I went. It is important to keep the item labels, numerical reults, and units in the proper order. 
- `data_frame()` is a `dplyr` function for creating a data frame from a set of vectors of the same length. The vector names become the column names in the data frame, as you can see by printing `calibr_results`. 

### write results to file

![](../resources/images/text-icon.png)<!-- -->

    # Write results to file
    
    Save the results table to file. 

![](../resources/images/code-icon.png)<!-- -->


```r
write_csv(calibr_results, "results/03_calibr_regression_results-table.csv")
```

Because this information is likely to appear in a client report, we save it to the `results` directory.  

![](../resources/images/text-icon.png)<!-- -->

    Add `y-fit` to the tidy data set and save it with `input_lb` and  `output_mV` for graphing later. 

![](../resources/images/code-icon.png)<!-- -->


```r
graph_data <- calibr_data %>%
	mutate(fit_mV = round(y_fit, 2)) %>%
	select(input_lb, output_mV, fit_mV)
```

Learn R.

- This code chunk can be read. "Assign `calibr_data` to `graph_data` *then* add a new column `fit_mV` that is the `y_fit` results rounded to two decimal places, *then* keep only the three columns listed."
- `round()` is a base-R function for rounding. For most cases, I usually use the `plyr::round_any()` function. For more information, type `?plyr::round_any` in the Console. 


```r
write_csv(graph_data, "results/03_calibr_regression_graph-data.csv")
```

Because these values are the basis for the calibration graph (to be drawn in the next script), we save this data frame to the `results` directory. 

### check yourself

Navigate to your results directory. it should look like this:

    results\
      |-- 03_calibr_regression_graph-data.csv
      `-- 03_calibr_regression_results-table.csv


