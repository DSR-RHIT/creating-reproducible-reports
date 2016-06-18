---
layout: page
title:  tutorial
tagline: set up knitr and readr
---

We're ready to add some R code to the document to read the calibration data file and print it to the report as a table. The *knitr* package enables integration of R code with the prose of the report. (An R *package* is like an app in R. Your packages are stored in the `C:/R/library` directory you created in the pre-workshop homework.)

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
 
### Install readr 

In the pre-workshop homework you installed the *plyr* package for practice. We'll need the *readr* package next. 

- In RStudio, lower right pane, *Packages -> Install* 
- Type *readr* 

--- 
Now go to the page to [read a data file and make a table](08-read-data-make-table.html)










