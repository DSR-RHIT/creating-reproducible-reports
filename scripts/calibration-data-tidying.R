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


