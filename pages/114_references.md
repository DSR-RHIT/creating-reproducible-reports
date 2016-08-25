---
layout: page
title: "adding references"
---








### summary 

I use the bib format (from BiBTeX) for bibliographies (other formats are available). The  basic steps are: 

- create the bib file  
- specify the bib file in the Rmd header  
- add the citation to the report  
- add a references heading 



### create the bib file 

To create the bib file: 

- Open a new text file in RStudio, *File* > *New File* > *Text File* 
- *Save As* `calibration.bib` in the `reports` directory 

![](../resources/images/text-icon.png)<!-- --> type in the new bib file

<pre class="r"><code>@manual{ansi-isa-1995,
    title = {Process instrumentation terminology},
    edition = {ANSI/ISA-S51.1-1979, reaffirmed 1995},
    organization = {Instrument Society of America},
    address = {Research Triangle Park, NC},
    year = {1995},
    note = {ISBN 0-87664-390-4},
}</code></pre>

- `ansi-isa-1995` is a label I assign for the in-text citation 
- `@manual` denotes the document type using standard BiBTeX syntax.  The site  [verbosus](https://verbosus.com/bibtex-style-examples.html) gives some guidance to the many document types, e.g., articles, proceedings, books, etc., and their bib arguments.   




### specify the bib file in the Rmd header

Add the bibliography argument to the front matter including the relative path if needed.  

![](../resources/images/text-icon.png)<!-- -->

<pre class="r"><code>---
title: "Load-cell calibration report"
author: "name"
date: "date"
output: word_document
bibliography: "calibration.bib"
---</code></pre>

 


### add the citation to the report

In the report Rmd file, add the citation for the ANSI/ISA standard at the end of the paragraph where the standard is first mentioned. 



![](../resources/images/text-icon.png)<!-- -->

<pre class="r"><code> . . . from the sensor are recorded. The test procedure follows the ANSI/ISA standard [@ansi-isa-1995]. 
</code></pre>

The citation syntax has the form `[@ansi-isa-1995]`: brackets indicate a citation using `@`  followed by the reference label we assigned in the bib file.


 


### add a references heading

At the end of the Rmd script, add a references section heading.

![](../resources/images/text-icon.png)<!-- -->

<pre class="r"><code># References
</code></pre>


