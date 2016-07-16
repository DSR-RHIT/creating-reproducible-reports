---
layout: page
title: "explore the data"
---





How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk, then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *knit* after each addition. 
- *Install* packages (like "apps") one time only
- *Load* a package using `library()` every session

Packages used in this tutorial 

- dplyr 
- tidyr 
- stringr
- readr

Learn R

- `.libPaths()` returns the location(s) of your package library, e.g., `C:/R/library` and `C:/Program Files/R/R-3.3.1/library`
- `library()` returns the names of installed packages and in which library they reside
- `search()` returns the names of loaded packages, ready to use 

### getting started

You have already started: open `01_calibr_data-wide.Rmd`. It should contain a YAML header and a code chunk to initialize `knitr`, as shown below. 

<pre><code>---
title: "Load-cell calibration --- data in wide form"
author: "your name"
date: "2016-08-24"
output: html_document
---

<code>```</code>{r}
library(knitr)
opts_knit$set(root.dir = '../')
opts_chunk$set(echo = TRUE, collapse = TRUE)
<code>```</code>
</code></pre>

For this tutorial

- Add text and code to `01_calibr_data-wide.Rmd` in the order presented
- Knit your document after each addition and confirm the output is what you expect

Knowing the packages we'll be using, we can load them right away, near the top of the file.

![](../resources/images/code-icon.png)<!-- --> (*add code*: insert a code chunk, then transcribe the R code) 


```r
# load packages
suppressPackageStartupMessages(library(dplyr))
library(tidyr)
library(stringr)
library(readr)
```

By itself,  `library(dplyr)` produces several message in our output. To suppress those messages, we use the `suppressPackageStartupMessages()` function to load the `dplyr` library.

### import the image 

![](../resources/images/text-icon.png)<!-- --> (*add text*: type the prose verbatim into the Rmd file) 

    # Import the image

    The image shows that a force is applied vertically by hanging a weight on the eye hook. The thin-beam load cell deflects, causing the bridge to produce a voltage signal proportional to the applied force. Measurement units: input force (lb), output signal (mV). 

Learn R Markdown:

- In Rmd, the single hash tag `#` denotes a level-1 heading. 

![](../resources/images/code-icon.png)<!-- -->


```r
include_graphics("../resources/load-cell-setup-786x989px.png", dpi = 250)
```

Learn R

- `include_graphics()` (from `knitr`) imports an image to the Rmd document, but it ignores our `root.dir = '../'`  option set earlier. Instead, it treats the directory in which our script resides as the working directory. Thus the relative path argument (`"../resources/filename.png"`) starts with  `../` to go up one level, then down a level to the `resources` directory and the desired file.
- `dpi` scales the size of the image, where image\_width = width\_pixels / dpi. You can edit the `dpi` setting to see the effect in the output.
- Arguments of R functions use a `key = value` assignment structure, e.g. `dpi = 250`. 

To add a figure caption, use the `fig.cap` option inside the braces that start the code chunk:

    {r, fig.cap = 'Figure 1. Load cell calibration test setup'}

- Single quotes and double quotes are treated the same. Your choice. 




### read and examine the data

![](../resources/images/text-icon.png)<!-- --> 

    Read the data as received and examine its structure.

![](../resources/images/code-icon.png)<!-- -->


```r
data_received <- read_csv('data/007_wide-data.csv')
glimpse(data_received)
```

Learn R

- `read_csv()` (from `readr`)  returns a *data frame* structure
- `glimpse()` (from `dplyr`)  returns an object's structure

Writing readable code

- Choose meaningful names for things (this is not easy)
- Use underscores to separate words in object names
- One space on either side of `<-`
- See Hadley Wickham's [style guide](http://adv-r.had.co.nz/Style.html) for more suggestions 

![](../resources/images/text-icon.png)<!-- --> 

    The data object is a data frame. 

Data frames are a common way of storing data in R. You can think of a data frame as a data rectangle: a 2D array of rows and columns. (Formally, though, a data frame is a  *list* of *vectors*). 

- Columns are equal-length vectors
- Every element in a vector is of the same *type*, e.g., logical, integer, double, character, etc.
- Different columns can be of different types

### check yourself

Confer with a neighbor. 

1. The `glimpse()` function tells us there are how many *variables* (column names)? 
2. How many of the variables are type character? 
3. How many are type double (i.e., double precision floating point)? 

![](../resources/images/code-icon.png)<!-- -->


```r
# look at the first few rows of the data set.
head(data_received)
```

Learn R
 
- `head()` displays the first few rows of a data frame 
- In the output, the leftmost column of numbers are *row names*. Default row names are character numerals. 

![](../resources/images/text-icon.png)<!-- --> 

    The data set has mV readings in several columns, designated *cycle_1*, *cycle_2*, etc. This is wide form and will have to be reshaped to long form for analysis. 

    The NA values in the first and last cycles represent are values that were not tested, per the ANSI/ISA standard. These NA observations can be deleted when we tidy the data. 

    A statistical summary of the numerical columns is useful for looking for data anomalies. 
    
Learn Rmd

- A pair of asterisks `*word or phrase*` typesets in *italics*

![](../resources/images/code-icon.png)<!-- -->


```r
# keep the numeric columns for a statistical summary
input_output_data <- data_received %>%
    select(-test_point)
```

Learn R

- `%>%` (from `magrittr` via `dplyr`) is a *pipe operator* that can be thought of as the adverb *then*
- `select()` (from `dplyr`) chooses columns to keep; or with a minus sign, the column to delete

We can read this code as, start with `data_received`, then select all but the `test_point` column, and assign the result to `input_output_data`. 

Writing readable code

- Starting a new line after `%>%` enhances code readability, especially when using multiple pipes sequentially (do this, then that, then that, etc.)  

![](../resources/images/code-icon.png)<!-- -->


```r
summary(input_output_data)
```

Learn R

- `summary()` produces a statistical summary of each column

### check yourself

Confer with a neighbor. 

1. The summary shows how many NAs total?  
2. The overall minimum mV reading is? overall maximum?  

![](../resources/images/text-icon.png)<!-- --> 

    For all cycles, the mean, min, and max  readings (mV) are similar. We have NA in the first and last cycles only, as expected.  

### create a data table for the report

![](../resources/images/text-icon.png)<!-- --> 

    # Create a data table for the report

    A conventional calibration report includes a data table in wide form. All we have to do is format it nicely and save it to our `results` directory for later use. 

    Start with the data set without the test-point column (`input_output_data` created earlier) and edit the column names for printing to the client report. 

Learn Rmd

- A pair of back ticks \``word or phrase`\` typesets in `typwriter` font

![](../resources/images/code-icon.png)<!-- -->


```r
# begin editing the column names for the report printout
table_head <- colnames(input_output_data)
# ensure all strings are lower case for str_replace and str_detect
table_head <- tolower(table_head)
```

- `colnames()` returns the column names of the data frame
- `tolower()` makes all strings lower case

![](../resources/images/code-icon.png)<!-- -->


```r
# replace underscores with spaces
table_head <- str_replace(table_head, "_", " ")
# format the input units as (lb)
table_head <- str_replace(table_head, "lb", "(lb)")
```

- `str_replace()` (from `stringr`) replaces one string with another

![](../resources/images/code-icon.png)<!-- -->


```r
# add the output units to the cycle headings
cycle_true <- str_detect(table_head, "cycle")
cycle_head <- table_head[cycle_true]
cycle_head <- str_c(cycle_head, " (mV)")
```

- `str_detect()` (from `stringr`) returns a logical vector; `TRUE` means that the column name contains `cycle` 
- `[cycle_true]` subsets the table head, selecting those marked `TRUE`
- `str_c()` (from `stringr`) concatenates " (mV)" with every element of `cycle_head`

Writing readable code

- Align the assignment operator `<-` of sequential lines of code where feasible.

![](../resources/images/code-icon.png)<!-- -->


```r
# reassign
table_head[cycle_true] <- cycle_head
```

- The edited cycle-column names overwrite correct subset of `table_head`

![](../resources/images/code-icon.png)<!-- -->


```r
# substitute a capital letter for the first letter of each element
table_head <- gsub("^([a-z])", "\\U\\1", table_head, perl = TRUE)
```

Here, we use *regular expression* syntax to capitalize the first letter of each column heading. Regular expressions do not lend themselves to quick explanations, so I'm not going to try. But you can learn about it at  [STAT 545](http://stat545.com/block022_regular-expression.html). 

![](../resources/images/text-icon.png)<!-- --> 

    Reassign the edited table heading to the data frame. 

![](../resources/images/code-icon.png)<!-- -->


```r
# reassign 
colnames(input_output_data) <- table_head
```

![](../resources/images/text-icon.png)<!-- --> 

    Print the table as it would appear in the report to check it. 

![](../resources/images/code-icon.png)<!-- -->


```r
# print to check
kable(input_output_data, caption = "Table 1. Calibration data")
```

Learn knitr

- `kable()` (from `knitr`) prints a data frame as a table
- Captions are added as one of the function arguments 

### save to file 

![](../resources/images/text-icon.png)<!-- --> 

    # Save to file

![](../resources/images/code-icon.png)<!-- -->


```r
# save to results directory
write_csv(input_output_data, "results/01_calibr_data-wide.csv")
```

- `write_csv()` (from `readr`) writes a data frame to the relative path and file name indicated
- The `results` directory is used because we intend to include this table in the client report. 
- Setting the `knitr` option `root.dir = "../"` in our preamble means that the relative path in this write function starts at the top level of our project, our RStudio Project working directory


### check yourself

Your directories should contain these files:

    data\
      `-- 007_wide-data.csv

    reports\
    
    resources\
      `-- load-cell-setup-786x989px.png 
      
    results\
      `-- 01_calibr_data-wide.csv
      
    scripts\
      |-- 01_calibr_data-wide.html
      `-- 01_calibr_data-wide.Rmd 

### coda

It can be useful to periodically clear the workspace and run the script afresh or to run the R code by itself without compiling the output document. 

- Clear the workspace:  `Session > Restart R` (Win/Linux `Ctrl + Shift + F10`, MacOS `Command + Shift + F10`)
- Run the R code only:  `Code > Run Region > Run All` (Win/Linux `Ctrl + Alt + R`, MacOS  `Command + Option + R`)
- Clear the console: `Ctrl + L`
- Check spelling: `F7`


`Tools > Keyboard Shortcuts Help` to see all the keyboard shortcuts. 


---
Back [start your first script](105_first-script.html)<br>
Next [tidy the data](110_tidy-data.html)

