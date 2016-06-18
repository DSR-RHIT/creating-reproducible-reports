---
layout: page
title:  tutorial
tagline: inline code and table formatting
---

### Inline code

Looking over the data, we see the number of observations and trials. We can bring that information to the reader's attention in the prose using some *inline R code*. 

- Let's add to the previous sentence. 

	<pre><code>The calibration data are shown in Table 1. These data comprise `r nrow(calibr_data)` observations over `r max(calibr_data$cycle)` up-down cycles. Per the ANSI standard, the test begins and ends at the same mid-cycle test point in the same direction.  
	</code></pre>

We use the R *nrow()* function to determine the number of rows in the *calibr_data* data frame. Placing this R code inside the  ``r `` delimiters executes the function and places the result in the text. 

We use the R `$` notation in *calibr_data$cycle* to extract the the *cycle* column from the data frame, then use the *max()* function to determine its largest value. Again, putting this small bit of r code inside the in-line delimiters executes the code and prints the result to the report document. 



### Edit the styles 

In the Word document, I want to reformat the table entries to take up a bit less space. 

- Select one of the rows of the tabulated data 
- Change its format: Calibri, 10 pt, paragraph zero space before and zero space after, 1.15 line spacing 
- In the Styles window, find the assigned style (Compact) and click Update to match selection 
- Save As and overwrite *mystyles-01.docx*  
- Close the file 

Return to the Rmd file 

- Knit 

The table in the document should have the new formatting 



 
 
 







--- 
Now go to the page about (add link)










