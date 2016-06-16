#-----------------------------------------------------------
#
#   define-latex-colors.R
#
#   2013-08-18
#   RAL
#
#-----------------------------------------------------------

library(RColorBrewer)
library(stringr)

# brown/blue-green (div)
BrBG <- brewer.pal(8,"BrBG")
# remove hashtag and quotes to use in LaTeX xcolor package
BrBG <- noquote(str_replace(BrBG, '#', ''))
darkBr  = BrBG[1]
medBr   = BrBG[2]
lightBr = BrBG[3]
paleBr  = BrBG[4]
paleBG  = BrBG[5]
lightBG = BrBG[6]
medBG   = BrBG[7] 
darkBG  = BrBG[8]

# purple-green (div)
PRGn <- brewer.pal(8,"PRGn")
PRGn <- noquote(str_replace(PRGn, '#', ''))
darkPR  = PRGn[1]
medPR   = PRGn[2]
lightPR = PRGn[3]
palePR  = PRGn[4]
paleGn  = PRGn[5]
lightGn = PRGn[6]
medGn   = PRGn[7] 
darkGn  = PRGn[8]

# grays
Grays <- brewer.pal(8,"Greys")
Grays <- noquote(str_replace(Grays, '#', ''))
gray1 = Grays[1]
gray2 = Grays[2]
gray3 = Grays[3]
gray4 = Grays[4]
gray5 = Grays[5] 
gray6 = Grays[6]
gray7 = Grays[7] 
gray8 = Grays[8]

# last line                
