# Multitemporal analysis of vegetation health and landscape variability in the Blue Mountains National Park (Australia) due to the bushfires of 2019-2020.

# Installing the packages necessary for the analysis.  
install.packages("devtools") # Needed to download packages directly from GitHub repositories.
install.packages("terra") # Essential for managing spatial data, particularly raster and vector data (e.g. satellite images).
install.packages("ggplot2") # Used for creating statistical graphs. 
install.packages("patchwork") # Useful for combining multiple plots in a single window for comparison.
install.packages("viridis") # Used for applying colorblind-friendly and uniform color palettes.

# Recalling the package "devtools" to install "imageRy". 
library(devtools)

# Installing "imageRy" package from GitHub.
install_github("ducciorocchini/imageRy") # Consent the use of specialized functions for environmental monitoring.

# Recall all the other packages.
library(terra)
library(ggplot2)
library(patchwork)
library(viridis)
library(imageRy)

# Setting the working directory to upload the satellite images.
setwd("/Users/giovannipremoli/Desktop/spatial ecology in R")

# Checking if the path is correct. 
getwd()

# Importing the 2019 Sentinel-2 images for the pre-fire analysis. TC stands for True Colors and FC for False Colors. The images I've chosen are all cloudless.
tc19 <- rast("2019_TC.jpg") # rast() imports the file as a SpatRaster object, preserving its multilayer structure. 
fc19 <- rast("2019_FC.jpg") 

