# calibration data tidying

# load libraries
library(dplyr)
library(readr)

# read the data, keep in wide form for the printed table
df_wide <- read_csv('data/calibration-table.csv')

# long form, used for the analysis, can omit the first column
df_long <- df_wide %>%
  select(-test_point)

# indices for gather cycles from wide to long form
cycle_cols <- grep('cycle', names(df_long))

# gather wide to long, producing a 2-column (x-y) data frame
df_long <- df_long %>%
  gather(cycle_no, output_mV, cycle_cols) %>%
  select(-cycle_no)

# delete rows with NA
keep_rows <- complete.cases(df_long)
df_long <- df_long[keep_rows, ]

# values for reporting
n_cycles <- length(cycle_cols)
n_observ <- nrow(df_long)


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

