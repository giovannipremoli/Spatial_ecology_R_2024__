# Code to import external data

library(terra)
# download images from Nasa Earth Observatory 

setwd("/home/duccio/Downloads") # set the working directory from which we want to take the images 
# Windowds: "C:\\path\Downloads" -> "C://path/Downloads"

getwd()

scotland <- rast("scotland_outerhebrides_oli_20240918_lrg.jpg") # command to import data 
plotRGB(scotland, r=1, g=2, b=3)
plot(scotland) # same of plotRGB to see the picture on R

# Exercise: download a set of the Earth Observatory and upload it in R
drought <- rast("washingtondrought_oli_20170730_lrg.jpg"
plot(drought)                
