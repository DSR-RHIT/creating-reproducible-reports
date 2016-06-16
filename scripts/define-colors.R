#-----------------------------------------------------------
#
#   define-colors.R
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

# License BSD-3-clause
#
# Copyright (c) 2016, Richard Layton
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#   
#   1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
# 
# This software is provided by the copyright holders and contributors "as is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the copyright holder or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.


