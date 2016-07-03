---
layout: page
title: "first look at the data"
---





Packages used in this tutorial 

- readr 
- dplyr 

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 


### introduction  

Our first paragraph establishes the context for the analysis.

![](../resources/images/text-icon.png)<!-- --> 

```
# Introduction

Calibration test data for an Omega LCL-005 (0--5 lb) load cell (a force sensor) has been provided by the test lab. The goal of this analysis is to determine the calibration equation and estimate the sensor accuracy. 
```
Learning R Markdown:

- In Rmd, the single hash tag `#` denotes a level-1 heading. 

![](../resources/images/text-icon.png)<!-- -->

```
The lab sent an image of the test setup. A known weight (lb) is attached to the eye hook and the load cell bridge produces an output signal (mV).
```

![](../resources/images/code-icon.png)<!-- -->


```r
knitr::include_graphics("../resources/load-cell-setup-786x989px.png", dpi = 200)
```

Learning R:

- `::` tells R to run the *knitr* package  *include_graphics()* function  
- *include_graphics()* imports the image 
- The file path in quotes starts with `../` to move one directory level up (the project-level directory), down to `resources/`, and then to the file name.
- `dpi` scales the size of the image, where image\_width = width\_pixels / dpi. 
- Inside an R function, the equals sign `=`  is used to assign values to arguments. 

To add a figure caption, use the `fig.cap` option inside the brackets that start the code chunk, for example, 

<pre><code>{r, fig.cap = 'Figure 1. Load cell calibration test setup'}
</code></pre>

- R is agnostic when it comes to quotation marks. Single quotes and double quotes are treated the same. 
- Again, you see that an equals sign `=`  is used to assign values to arguments. 

The output to the screen is shown below. You can edit the `dpi` setting to see the effect of changing the scaling. 




<div class="figure">
<img src="../resources/load-cell-setup-786x989px.png" alt="Figure 1. Load cell calibration test setup" width="377" />
<p class="caption">Figure 1. Load cell calibration test setup</p>
</div>


### examine the data 

![](../resources/images/text-icon.png)<!-- --> 

```
# Examine the data 
```

 ![](../resources/images/code-icon.png)<!-- --> 
 

```r
# read the data set as received
library(readr)
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

```
First look at the data structure.
```

![](../resources/images/code-icon.png)<!-- --> 


```r
str(data_received)
```

Learning R: 

- *str()* displays the structure of an R object 

![](../resources/images/text-icon.png)<!-- --> 

```
As expected, *read_csv()* produced a data frame. All columns are numerical except the *test_point* column that shows test condition number and a direction.
```
- Asterisks around a word or phrase are the Rmd syntax for italics.

![](../resources/images/text-icon.png)<!-- -->  

```
Look at the first few rows of the data set. 
```

![](../resources/images/code-icon.png)<!-- --> 


```r
head(data_received)
```

Learning R:
 
- *head()* displays the first few rows of the data set. 
- the numbers in the leftmost column of the output are *row names*, i.e.,  character strings (not integers) assigned by default


![](../resources/images/text-icon.png)<!-- --> 

```
The data set has mV readings in several columns, designated *cycle_1*, *cycle_2*, etc. Thus, the data are in wide form and will have to be reshaped to long form for analysis. 

I see some NA values, which is consistent with the calibration test protocol. A summary of the numerical columns might be useful.
```

![](../resources/images/code-icon.png)<!-- -->  


```r
library(dplyr)
# summary-stats except column 1
partial_data_set <- data_received %>%
	select(-test_point)
summary(partial_data_set)
```

Learning R:

- The pipe operator `%>%` can be thought of as the adverb "then". Thus, this code chunk could be read as "Assign the `data_received` data frame to a new object named `partial_data_set`; *then* select all but the `test_point` column.  
- *select()* operates on the columns of a data frame 
- *summary()* produces a statistical summary of each column in the data frame. 
 
![](../resources/images/text-icon.png)<!-- -->
 
```
For all cycles, the mean, min, and max  readings (mV) are similar. We have NA in the first and last cycles only, as expected.  
```

Now that we know something about this data set, we're ready to begin preparing the data for analysis. 





<br><br><br>
