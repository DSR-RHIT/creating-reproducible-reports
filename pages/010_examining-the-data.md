---
layout: page
title: examining the data 
---


[//]: this is a comment in Rmd



If you haven't already, install the *readr* package from RStudio using *Packages -> Install -> readr*. 



### reading the data 

Insert a code chunk and add this R code: 


```r
# match the knitr root directory to the project working directory
library(knitr) 
opts_knit$set(root.dir = '../')
```

Add this explanatory prose

```
Input the data file that was provided. 
``` 
 
followed by a code chunk ![insert-code-chunk-icon](../resources/images/insert-code-chunk-icon.png) with this R code: 


```r
# assign the data to a variable name
library(readr)
wide_data <- read_csv('data/009_wide-data.csv')
```

Save and Knit. Notes on the script: 

- `# comment` a hash tag in R denotes a comment 
- `library()` loads a package so we can use its functions 
- `<-` is the R assignment operator 
- `read_csv()` the path to the CSV file is relative to the project working directory  


### examining its structure 

Add prose

```
Examine the data object's structure.
```

followed by a code chunk ![insert-code-chunk-icon](../resources/images/insert-code-chunk-icon.png) with this R code:


```r
str(wide_data)
```


Save and Knit. Notes on the script: 

- `str()` returns the structure of the R object. When we read a csv file using `read_csv()` the object typically belongs to three R *classes*: tbl_df, tbl, and data.frame. The data frame class is the one we will use regularly. 

Add prose:

```
The data frame has 8 observations (rows) of 5 variables (columns). Several columns are separate test cycles, indicating we have a "wide" rather than a "long" data set. 

The column headings tell us that the applied force is in pounds (lb). From a conversation with the test lab, we know the readings are in mV. 
```

--- 

