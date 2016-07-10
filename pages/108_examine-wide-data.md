---
layout: page
title: "examine the wide-form data"
---





Continue adding text and code to `01_calibr_data-reshaping` file. 

Packages used in this tutorial 

- readr 
- dplyr 

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 

Knowing the packages we'll be using, we can load them right away, near the top of the file.

![](../resources/images/code-icon.png)<!-- -->


```r
# load packages
library(readr)
suppressPackageStartupMessages(library(dplyr))
```

Loading the `dplyr` package produces several message in our output. To suppress those messages, we use the `suppressPackageStartupMessages()` function.

### introduction  

Our first paragraph establishes the context for the analysis.

![](../resources/images/text-icon.png)<!-- --> 

    # Introduction

    Calibration test data for an Omega LCL-005 (0--5 lb) load cell (a force sensor) has been provided by the test lab. The goal of this analysis is to determine the calibration equation and estimate the sensor accuracy. 
    
    The lab has made available an image of the test setup on the Internet. 

Learning R Markdown:

- In Rmd, the single hash tag `#` denotes a level-1 heading. 

The following code chunk downloads the image from the Internet to your local project resources directory. 

![](../resources/images/code-icon.png)<!-- --> 


```r
url <- "https://raw.githubusercontent.com/DSR-RHIT/creating-reproducible-reports/gh-pages/resources/load-cell-setup-786x989px.png"

destination <- "resources/load-cell-setup-786x989px.png"

download.file(url, destination, mode = "wb")
```

Learning R.

- `download.file()` finds the file at the URL listed and saves it to your local machine 
- the destination is a relative path with respect to your RStudio Project working directory. 
- `mode = "wb"` permits us to download a PNG file or any other non-textual or "binary" file 

You should find the image saved to your `resources` directory. If not, navigate to [https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources/downloads](https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources/downloads) and follow the instructions to download the image file to your resources directory. 

When finished, your resources directory should look like this. 

```
resources\
  `-- load-cell-setup-786x989px.png
```

![](../resources/images/text-icon.png)<!-- -->

    The image of the test setup shows that a known weight (lb) is attached to the eye hook and the load cell bridge produces an output signal (mV).

![](../resources/images/code-icon.png)<!-- -->


```r
knitr::include_graphics("../resources/load-cell-setup-786x989px.png", dpi = 250)
```

Learning R:

- `::` tells R to run the *knitr* package  *include_graphics()* function  
- *include_graphics()* imports the image from our local directory to the Rmd document 
- The file path in quotes starts with `../` to move one directory level up (the project-level directory), down to `resources/`, and then to the file name.
- `dpi` scales the size of the image, where image\_width = width\_pixels / dpi. 
- Inside an R function, the equals sign `=`  is used to assign values to arguments. 

To add a figure caption, use the `fig.cap` option inside the brackets that start the code chunk:

    {r, fig.cap = 'Figure 1. Load cell calibration test setup'}

- Single quotes and double quotes are treated the same. 
- Again, you see that an equals sign `=`  is used to assign values to arguments. 

The output to the screen is shown below. You can edit the `dpi` setting to see the effect of changing the scaling. 

<div class="figure">
<img src="../resources/load-cell-setup-786x989px.png" alt="Figure 1. Load cell calibration test setup" width="377" />
<p class="caption">Figure 1. Load cell calibration test setup</p>
</div>

### examine the data 

![](../resources/images/text-icon.png)<!-- --> 

    # Examine the data 
    
    Download the data from the Internet repository. 

![](../resources/images/code-icon.png)<!-- --> 


```r
url <- "https://raw.githubusercontent.com/DSR-RHIT/creating-reproducible-reports/gh-pages/data/007_wide-data.csv"

destination <- "data/007_wide-data.csv"

download.file(url, destination)
```

You should find the data saved to your `data` directory. If not, navigate to [https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources/downloads](https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources/downloads) and follow the instructions to download the data file to your data directory. 

When finished, your  data directory should look like this. 

```
data\
  `-- 007_wide-data.csv
```

![](../resources/images/text-icon.png)<!-- --> 

    Read the data from our local copy into the R workspace. 

![](../resources/images/code-icon.png)<!-- --> 
 

```r
# read the data set as received
data_received <- read_csv('data/007_wide-data.csv')
```

Learning R:

- This code chunk reads the data you downloaded to your `data` directory. 
- *read_csv()* is a function in the *readr* package
- The assignment operator `<-` assigns the object returned by the *read_csv()* function (a data frame) to the object name I've chosen, `data_received`

Some note on coding practice for readability

- Choose meaningful names for things (this is not easy)
- Use underscores to separate words in object names

![](../resources/images/text-icon.png)<!-- -->  

    First look at the data structure.

![](../resources/images/code-icon.png)<!-- --> 


```r
# display the structure of the R object
str(data_received)
```

The data are stored in a *data frame*: a 2-dimensional rectangle of information in rows and columns. The different columns can be different types (numeric, character, logical, etc.), but they're all the same length. 

### check yourself

Confer with a neighbor. 

1. The `str()` function tells us there are how many variables? 
2. How many of the variables are numeric? character? 

![](../resources/images/text-icon.png)<!-- -->  

    Look at the first few rows of the data set. 

![](../resources/images/code-icon.png)<!-- --> 


```r
head(data_received)
```

Learning R:
 
- *head()* displays the first few rows of the data set. 
- the numbers in the leftmost column of the output are *row names*, i.e.,  character strings (not integers) assigned by default

![](../resources/images/text-icon.png)<!-- --> 

    The data set has mV readings in several columns, designated *cycle_1*, *cycle_2*, etc. Thus, the data are in wide form and will have to be reshaped to long form for analysis. 

    The NA values in the first and last cycles are due to the ANSI/ISA test protocol. The testing begins and ends at mid-span. Thus when we tidy the data, we an omit the NA observations. 

    A statistical summary of the numerical columns is useful for looking for data anomalies.

![](../resources/images/code-icon.png)<!-- -->  


```r
# summary-stats except column 1
partial_data_set <- data_received %>%
	select(-test_point)
summary(partial_data_set)
```

Learning R:

- The pipe operator `%>%` can be thought of as the adverb "then". Thus, this code chunk could be read as "Assign the `data_received` data frame to a new object named `partial_data_set`; *then* select all but the `test_point` column.  
- *select()* operates on the columns of a data frame 
- *summary()* produces a statistical summary of each column


### check yourself

Confer with a neighbor. 

1. The summary shows how many NAs total?  
2. The overall minimum mV reading is? overall maximum?   


![](../resources/images/text-icon.png)<!-- -->

    For all cycles, the mean, min, and max  readings (mV) are similar. We have NA in the first and last cycles only, as expected.  

    Now that we know something about this data set, we're ready to begin preparing the data for analysis. 


---
Back [initializing an Rmd script](105_initializing-an-Rmd-script.html)<br>
Next [data reshaping](109_data-reshaping.html)
