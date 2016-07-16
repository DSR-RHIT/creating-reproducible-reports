---
layout: page
title: "adding references"
---





How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk, then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *knit* after each addition. 
- *Install* packages one time only
- *Load* a package using `library()` every session

Packages used in this tutorial 

- 
- 
- 


I use the `.bib` format to automate the formatting of citations and references. This format comes to us from the LaTeX/BiBTeX world, but like the formatting of mathematics, has been adapted to R Markdown.  

### write the `.bib` file 

Open a new text file: File > New File > Text File. Save As `06_calibr_report.bib`. The ANSI/ISA standard we've referred to is typed into the .bib file as follows. 

![](../resources/images/text-icon.png)<!-- -->

    @manual{ansi-isa-1995,
        title = {Process instrumentation terminology},
        edition = {ANSI/ISA-S51.1-1979, reaffirmed 1995},
        organization = {Instrument Society of America},
        address = {Research Triangle Park, NC},
        year = {1995},
        note = {ISBN 0-87664-390-4},
    }

Learn .bib

- `@manual` describes the type of entry, such as article, book, conference, etc. 
- `ansi-isa-1995` is a label to uniquely identify the reference. I typically use `author-yyyy` labels
- The rest of the fields are self-explanatory. See [here for a guide](https://verbosus.com/bibtex-style-examples.html) to the different fields in different types of .bib entries. 


### specify the bibliography file in the front matter

Open the report Rmd file. Add the bibliography argument to the front matter,  including the relative path if needed.




### cite references in R Markdown format



### include a references section heading at the end of the Rmd script



---

Back [write the client report](113_report.html)<br>
Next [formatting docx](115_formatting.html)


