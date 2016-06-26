---
layout: page
title:  organizing files
tagline: tutorial
---

### set up a directory tree

- If you haven't installed R and RStudio, [please do](002_pre-hw.html). 
- If you haven't created an RStudio project and the *.Renviron* file for the workshop, [please do](002_pre-hw.html). 


In your main project directory (I'll call it *rr-workshop* for convenience), create additional folders (sub-directories) named data, reports, resources, and scripts so that your project directory tree looks like this: 

```
rr-workshop\
  |-- data\
  |-- reports\
  |-- resources\
  |-- scripts\
  |-- rr-workshop.Rproj
  `-- .Renviron
```




### download prepared files 
 
Navigate to my [workshop downloads](https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources) folder. To download a file, 

- Click the file name 
- Right-click Raw --> Save link as... 
- Save the CSV files to the *data* directory 
- Save the PNG file to the *resources* directory 

The data and reports directories should look like this. 

```
data\
  `-- 007_wide-data.csv
  
resources\
  `-- load-cell-setup-315x396px.png
```






--- 
back [main page](../index.html)<br> 
back [initialize a script](005_initialize-script.html)
