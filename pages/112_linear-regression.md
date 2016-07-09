---
layout: page
title: "linear regression"
---





Packages used in this tutorial  

- readr
- dplyr
- tibble

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 

### open a new Rmd script

We start a new Rmd script to perform the linear regression analysis and save the results to file.  

- Open a new Rmd file, and name it `04_calibr_regression.Rmd`
- Start the new script with the same YAML header as the previous script
- Change the title to `"Load-cell calibration --- linear regression"`
- Insert the same code chunk for the knitr setup 

Knowing the packages we'll be using, we can load them right away, near the top of the file.

![](../resources/images/code-icon.png)<!-- -->


```r
# load packages
library(readr)
suppressPackageStartupMessages(library(dplyr))
```

### perform the linear regression 

![](../resources/images/text-icon.png)<!-- -->

    # Perform the linear regression 

![](../resources/images/code-icon.png)<!-- -->


```r
# read the tidy data
calibr_data <- read_csv("results/02_calibr_data-tidying.csv")
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

- The linear model function has the form `lm(y ~ x, data = data_frame)`, that is, `y` as a function of `x`, where `y` and `x`  are variables (column names) in `data_frame`
- The argument `y ~ x` is called a *formula* in R  
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
- `regr_results` contains 12 named objects (collected in an R data structure called a *list*.)
- Add `attributes()` to your list of functions used for exploring data, including `str()`, `head()`, and `tail()`. 

![](../resources/images/text-icon.png)<!-- -->

    The named variables we need from this list are `[1] coefficients`, `[2] residuals`, and `[5] fitted.values`. Examining the structure of these three variables yields

![](../resources/images/code-icon.png)<!-- -->


```r
# Examine the three objects we want
regr_results_subset <- regr_results[c("coefficients", "residuals", "fitted.values")]
str(regr_results_subset)
```

- We subset `regr_results` using `[]` notation and the three named objects of interest.
- We use `str()` to examine the stucture of each of the three objects. 
- Recall `c()` is how we *combine* elements into a vector

### check yourself

Confer with a neighbor.

1. How many elements in the `coefficients` vector?
2. What is the numeric value of the regression intercept? of the slope? 
3. How many elements in the `residuals` vector? Does it make sense? 

In our linear model, `lm()`, the coefficient of the $x^0$ term is labeled *Intercept*; the coefficient of the $x^1$ term is labeled the 
*input_lb* coefficient, i.e., the  coefficient of $x^1$. This is our slope.   (Higher-order polynomial fits will have additional coefficients, of course, for $x^2, x^3$, etc.)

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

- `regr_results` is a list of 12 named objects. 
- A named object can be retrieved from a list using `$` subsetting notation having the form `list_name$object_name`, e.g., `regr_results$residuals`
- `regr_results$coefficients` returns a vector of 2 numbers, subsetted further using `[]` notation 

### determine sensor accuracy

![](../resources/images/text-icon.png)<!-- -->

    # Determine sensor accuracy
    
    The ANSI/ISA calibration standard defines accuracy as the maximum positive and maximum negative residual. 

![](../resources/images/code-icon.png)<!-- -->


```r
# determine largest absolute value residual
resid_max   <- max(residuals)
resid_min   <- abs(min(residuals))
resid_bound <- max(resid_max, resid_min)
```

- `max()` and `min()` are R functions that do the obvious

![](../resources/images/text-icon.png)<!-- -->

    In percentage form, accuracy is a percent of output span. The standard defines output span as the difference between the max and min y-fitted values.

![](../resources/images/code-icon.png)<!-- -->


```r
output_span <- max(y_fit) - min(y_fit)
accuracy    <- resid_bound / output_span * 100
```

R coding practice:

- Place a space before and after math operators, e.g., `+`, `-`, `/`, `*`, etc. for readability

![](../resources/images/text-icon.png)<!-- -->

    Display the values. 

![](../resources/images/code-icon.png)<!-- -->


```r
accuracy
```

### check yourself

Confer with a neighbor.

1. What is your sensor accuracy in percent?

### collect results 

![](../resources/images/text-icon.png)<!-- -->

    # Collect results 
    
    I’d like to collect min/max inputs and outputs in case I need them in the report.

![](../resources/images/code-icon.png)<!-- -->


```r
input_min  <- min(calibr_data[ , 'input_lb'])
input_max  <- max(calibr_data[ , 'input_lb'])
output_min <- min(calibr_data[ , 'output_mV'])
output_max <- max(calibr_data[ , 'output_mV'])
```

Learn R.

- We use `[row, col]` notation to subset an object. Here we select all rows (the row position is left blank) and only one column (e.g. `input_lb`). 

![](../resources/images/text-icon.png)<!-- -->

    Collect those results I’d like to keep handy.

![](../resources/images/code-icon.png)<!-- -->


```r
# create a data frame for printing a table of results
options(digits = 3)
library(tibble)
calibr_results <- frame_data(
    ~item,         ~value,      ~units,
    'input_min',   input_min,   'lb',
    'input_max',   input_max,   'lb',
    'output_min',  output_min,  'mV',
    'output_max',  output_max,  'mV',
    'slope',       slope,       'mV/lb',
    'intercept',   intercept,   'mV',
    'resid_bound', resid_bound, 'mV',
    'accuracy',    accuracy,    '%'
)

calibr_results
```

Learn R.

- `options()` allows me to set the number of decimal places for printing, so if I print to the Console, the values are easy to read. Type `?options` in the Console to read about other options. 
- In this code chunk, I've deliberately placed each row on its own line to make it easy to compose and check. 
- `frame_data` from the new `tibble` package allows us to assemble a new data frame row by row. 
- In the first row, the tilde `~` identifies column names.

### write results to file

![](../resources/images/text-icon.png)<!-- -->

    # Write results to file
    
    Save the results table to file. 

![](../resources/images/code-icon.png)<!-- -->


```r
write_csv(calibr_results, "results/04_calibr_regression-results.csv")
```

Because this information is likely to appear in a client report, we save it to the `results` directory.  

### check yourself

Navigate to your results directory. it should look like this:

    results\
      |-- 02_calibr_data-tidying.csv
      |-- 03_calibr_graph.png
      `-- 04_calibr_regression-results.csv

---
Back [calibration graph](111_calibration-graph.html)<br>
Next [client report](113_client-report.html)
