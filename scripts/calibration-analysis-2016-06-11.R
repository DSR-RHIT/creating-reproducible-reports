# calibration report analysis

# perform the regression
regr_results <- lm(output_mV ~ input_lb, data = df_long)

# y-fitted values are used to graph the linear regression curve
y_fit <- regr_results$fitted.values

# span is needed to determine accuracy in percentage form
output_span  <- max(y_fit) - min(y_fit)

# selected regression results for printing to the document
regr_summ <- summary.lm(regr_results)
residuals <- regr_summ$residuals
intercept <- regr_summ$coefficients[1]
slope     <- regr_summ$coefficients[2]
adj_r_sq  <- regr_summ$adj.r.squared

# compute accuracy in mV and as a percentage for reporting
acc_plus  <- max(residuals)
acc_minus <- min(residuals)

acc_plus_pct  <- acc_plus / output_span * 100
acc_minus_pct <- acc_minus / output_span * 100

accuracy <- max(abs(c(acc_plus_pct, acc_minus_pct)))

# create a data frame for printing a table of results
Result <- c('slope', 'intercept', 'adjusted $R^2$', 'max residual', 'min residual')
Value  <- c(slope, intercept, adj_r_sq, acc_plus, acc_minus)
Units  <- c('mV/lb', 'mV', 'mV', 'mV', 'mV')
tabulated_results <- data.frame(Result, Value, Units)

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


