---
layout: page
title:  tutorial
tagline: read a data file and make a table
---
 
### Read the data file

At the bottom of the current Rmd file, after the figure caption, 

- add a code chunk labeled *read-data* 
- Save and Knit 

	<pre class="r"><code>```{r read-data}
	# a package for fast and easy file reading
	library(readr)
	
	# assign the CSV data to a variable for further manipulation
	calibr_data <- read_csv('data/load-cell-calibr-L3.csv')
	<code>```</code></code></pre>

Note the *read_csv()* argument includes the path/filename to the CSV file relative to the working directory for the project. The path argument is a character string, denoted in R with single quotes (or double quotes, no distinction). 

In the RStudio window, in the upper right pane, 

- Select the *Environment* tab 
- Click *calibr_data*  

The data set should appear in the *Source* pane (upper left). You can see the names of the data columns and the entries. This data set is *tidy*, i.e., variables are in columns and observations are in rows.  

The simplest of all R functions for printing a table is the *kable()* function in the *knitr* package.  


 
 
 







--- 
Now go to the page about (add link)










