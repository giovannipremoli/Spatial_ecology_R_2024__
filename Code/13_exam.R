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

# Importing the 2019 Sentinel-2 images for the pre-fire analysis. TC stands for True Colors (bands: red, green and blue)and FC for False Colors (bands: NIR, green, blue). The images I've chosen are all cloudless.
tc19 <- rast("2019_TC.jpg") # rast() imports the file as a SpatRaster object, preserving its multilayer structure. 
fc19 <- rast("2019_FC.jpg") 

# Visualizing the two images from 2019.
par(mfrow=c(2,1))
plot(tc19)
plot(fc19) 

dev.off() # Clearing the current graph window.

# Extracting the bands from 2019 images. Useful to classify the objects and extract more information from the data.
# From the TC image I'm taking the red (r), blue (b) and green (g) bands.
r19 <- tc19[[1]]
g19 <- tc19[[2]]
b19 <- tc19[[3]]

# From the FC image I'm taking the NIR band.
nir19 <- fc19[[1]] 

# Combining the bands in a single object.
stack19 <- c(r19, g19, b19, nir19)

# Plotting the result to verify the 4 layers.
plot(stack19)

# Visualizing the different bands in a RGB plot alternating their color representation. This is useful to highlight specific environmental features.
im.plotRGB(stack19, r=4, g=2, b=3) # NIR on red. Healthy vegetation appear bright red.
im.plotRGB(stack19, r=1, g=4, b=3) # NIR on green. Active clorophylle is highlighted in green tones.
im.plotRGB(stack19, r=1, g=2, b=4) # NIR on blue. Emphazize surface reflectance properties, useful to identify structural differences in the landscape.

# Calculating the Normalized Difference Vegetation Index (NDVI). The aim is to quantify vegetation health by measuirng the difference between NIR (reflected by leaves) and red wavelengths (absorbed by chlorophyll).
# My goal is to assess forest's health before the fires of late 2019 - early 2020.
# Formula: (NIR - red)/(NIR + red)

ndvi19 <- (nir19 - r19)/(nir19 + r19)

# Visualizing the NDVI map. Instead of creating a manual palette, I'm using the viridis function to ensure that maps are accesible to colorblind viewers.
# I'm also assigning a title to the plot with main =.
plot(ndvi19, col=viridis(100), main="NDVI 2019")

dev.off()

# Running the Principal Component Analysis on the 2019 stack. Useful to reduce data redundancy by compressing the information from all 4 spectral bands into fewer components.
# My aim is to obtain the maximum amount of environmental variability in a single layer (pc1).
pca19 <- im.pca(stack19)

# Standard Deviations obtained from R:
# pca1 = 22.300805
# pca2 = 13.894895
# pca3 = 8.694020
# pca4 = 2.365775



# Calculating the Standard Deviation (sd19) to measure the spatial hetereogeneity of the landscape.



