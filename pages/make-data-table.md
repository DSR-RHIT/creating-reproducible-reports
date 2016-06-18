---
layout: page
title:  tutorial
tagline: making a data table
---

We're ready to add some R code to the document to read the calibration data file and print it to the report as a table. The *knitr* package enables integration of R code with the prose of the report. (An R *package* is like an app in R. Your packages are stored in the `C:/R/library` directory you created in the pre-workshop homework. )

### Initialize knitr

- Near the top of the Rmd file, Just after the YAML header, add the code chunk delimiters: 

	<pre class="r"><code>```{r}
	
	<code>```</code>
	</code></pre>

In R Markdown files, a code chunk begins with the header ````{r}` (using backticks, not single quotes) and ends with three more backticks. You can type these delimiters, use the *Code -> Insert chunk* pulldown menu, or from the Rmd menu bar, use the button ![insert code chunk icon](../assets/images/insert-code-chunk-icon.png).

- To initialize *knitr*, edit the chunk as follows:  

	<pre class="r"><code>```{r setup}
	# load knitr library to access its functions
	library(knitr) 
	
	# set working directory for code chunks to match that of project
	opts_knit$set(root.dir = "../")
	
	# prevent code chunk output from being written to the report
	opts_chunk$set(include = FALSE)
	<code>```</code>
	</code></pre>

In the chunk header, *setup* is an arbitrary chunk label. If used, labels must be unique for every chunk. 

Comments in R code are delimited with a hashtag `#`. 

 - Save and Knit. 
 
You should find that the code chunk was printed to the report. To prevent this, set the include option to FALSE for this chunk, 
 
 - Change the chunk heading ````{r setup, include = FALSE}`  
 - Save and Knit 
 
 
 
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










