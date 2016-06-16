library(png)
library(raster)
library(grid)
library(lattice)
library(plyr)
library(latticeExtra)

# --------------- iteratively set manual parameters --------------- 

# draw a grid over the image to pick coordinates
draw_grid <- FALSE
delta_x   <- 0.2
delta_y   <- 0.1
grid_col  <- 'slateblue'

# select height of final figure in documenmt
# for h < original image, resolution increases
height_select <- 3.5 # inches (original was about 10 in)

# path to source image
filepath <- "data/2016-06-12-calibration/loadcell-image.png"
gray_scale  <- TRUE # FALSE keeps the color dimension

# desired size for final figure
font_size <- 8

# crop settings (in original scale)
cropping   <- FALSE # set to true to iteratively view result
crop_left  <- 150 # pixels
crop_right <- 150
crop_bot   <- 200
crop_top   <- 30

# white space to add (in original scale in pixels)
whitesp_left  <- 0
whitesp_right <- 360
whitesp_top   <- 0
whitesp_bot   <- 0

# --------------- create graph --------------- 

# read the original image and extract attributes
loadcell   <- readPNG(filepath, info = TRUE)
source_px  <- attributes(loadcell)$info$dim
source_res <- attributes(loadcell)$info$dpi[1]
source_in  <- source_px /source_res

# crop the original, set color
loadcell <- loadcell[(1 + crop_top):(source_px[2] - crop_bot)
                     , (1 + crop_left):(source_px[1] - crop_right)
                     , ]
if (gray_scale) loadcell <- loadcell[,,1]
if (cropping) grid.raster(loadcell)

# reset source dimensions to cropped dimensions
source_px <- source_px - c(crop_left + crop_right, crop_bot + crop_top)
source_in <- source_px /source_res

# apply new dimensions for saving rescaled image
scaled_res <- source_res * source_in[2] / height_select
scaled_w   <- source_px[1] / scaled_res
scaled_h   <- source_px[2] / scaled_res # should match h_select

# write to file the re-scaled image
png(filename = "data/2016-06-12-calibration/loadcell-resized.png"
    , width  = scaled_w
    , height = scaled_h
    , units  = 'in'
    , res    = scaled_res
)
grid.raster(loadcell)
dev.off()

# retrieve the intermediate image and extract attributes
loadcell   <- readPNG("data/2016-06-12-calibration/loadcell-resized.png", info = TRUE)
source_px  <- attributes(loadcell)$info$dim
source_res <- attributes(loadcell)$info$dpi[1]
source_in  <- source_px /source_res

# remove the temporary file
unlink("data/2016-06-12-calibration/loadcell-resized.png")

# transition to my normalized coord frame
# unit length x is the resized image x-pixels
# unit length y is the resized image y-pixels
scale_x  <- source_px[1] 
img_x0 <- 0
img_w  <- 1
x_min  <- 0 - round_any(whitesp_left  / scale_x, delta_x, ceiling)
x_max  <- 1 + round_any(whitesp_right / scale_x, delta_x, ceiling)
x_seq  <- seq(x_min, x_max, delta_x)
x_span_px <- (x_max - x_min) * source_px[1]

scale_y  <- source_px[2] 
img_y0 <- 0
img_h  <- 1
y_min  <- 0 - round_any(whitesp_bot / scale_y, delta_y, ceiling)
y_max  <- 1 + round_any(whitesp_top / scale_y, delta_y, ceiling)
y_seq  <- seq(y_min, y_max, delta_y)
y_span_px <- (y_max - y_min) * source_px[2]

# graph
my_scales = list(
    x = list(at = x_seq, limits = c(x_min, x_max))
  , y = list(at = y_seq, limits = c(y_min, y_max))
  , draw = ifelse(draw_grid, TRUE, FALSE)
  , alternating = c(3, 3)
  , col = grid_col
)
my_theme <- trellis.par.get()
my_theme$axis.line$col <- 'transparent'
my_panel <- function (x, y, ...) {
  grid.raster(loadcell
              , x = img_x0
              , y = img_y0
              , interpolate = TRUE
              , just = c('left', 'bottom')
              , default.units = "native"
              , width  = img_w
              , height = img_h
  )
  if (draw_grid) panel.abline(v = x_seq, h = y_seq, col = grid_col)
}
fig <- xyplot(0 ~ 0
       , xlab = NULL
       , ylab = NULL
       , panel = my_panel
       , scales = my_scales
       , par.settings = my_theme
)
print(fig)

# functions for the callouts. only for right-hand side so far
callout_right <- function(label, from, to){
  panel.segments(from[1], from[2], to[1], to[2])
  panel.text(to[1], to[2], label, adj = c(-0.06, NA))
}
add_note_right <- function(fig, label, to, from) {
  fig <- fig + layer(callout_right(label = label, to = to , from = from)
                     , data = list(label = label, from = from, to = to))
}

# --------------- edit callouts --------------- 

# assign and layer the callouts (use the normalized coords)
note_right <- 1.200
fig <- add_note_right(fig
                      , label = 'mounting bracket'
                      , from = c(1, 0.980)
                      , to = c(note_right, 1.000)
)
fig <- add_note_right(fig
                      , label = 'thin-beam load cell'
                      , from = c(0.500, 0.830)
                      , to = c(note_right, 0.900)
)
fig <- add_note_right(fig
                      , label = 'power-in to bridge'
                      , from = c(1.000, 0.775)
                      , to = c(note_right, 0.795)
)
fig <- add_note_right(fig
                      , label = 'signal-out to meter'
                      , from = c(1.000, 0.775)
                      , to = c(note_right, 0.755)
)
fig <- add_note_right(fig
                      , label = 'precision weight'
                      , from = c(1.000, 0.075)
                      , to = c(note_right, 0.075)
)

# further updates to  par.settings
my_theme$clip$panel    <- 'off'
my_theme$fontsize$text <- font_size
my_theme$add.line$lwd  <- 0.7
my_theme$add.line$col  <- 'gray40'
fig <- update(fig, par.settings = my_theme)
print(fig)

# to file
png(filename = "results/2016-08-calibr/figures/load-cell-setup.png"
    , width  = x_span_px
    , height = y_span_px
    , units  = 'px'
    , res    = source_res
)
print(fig)
dev.off()



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

