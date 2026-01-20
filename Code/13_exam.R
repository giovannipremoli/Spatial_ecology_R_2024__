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
# My aim is to obtain the maximum amount of environmental variability in fewer principal components, useful to have a more clear representation.
pca19 <- im.pca(stack19)

# Standard Deviations obtained from R:
# pca1 = 22.300805
# pca2 = 13.894895
# pca3 = 8.694020
# pca4 = 2.365775

# Calculating the total variability as the sum of SDs of the components.
tot19pca <- sum(22.300805, 13.894895, 8.694020, 2.365775)
# 47.2555

# Estimating the percentage of information represented by each axis.
22.300805*100/47.2555 # 47.19% (PC1)
13.894895*100/47.2555 # 29.40% (PC2)
8.694020*100/47.2555 # 18.40% (PC3)
2.365775*100/47.2555 # 5.01% (PC4)
# PC1 and PC2 together cover ~76.59% of the original information, which is enough to describe the landscape structure.
compactpca19 <- pca19[[1]] + pca19[[2]]

# Calculating the Standard Deviation (pcsd19), based on the principal components, to measure the spatial hetereogeneity of the landscape. I'm applying focal() function to calculate SD in a 3x3 moving window.
# Areas with high SD indicate high landscape complexity.
pcsd19 <- focal(compactpca19, matrix(1/9,3,3), fun=sd) 

# Visualizing the final variability map using a colorblind-friendly palette.
plot(pcsd19, col=viridis(100), main = "Landscape Variability 2019 (SD)")
     
# Classifying the image into 2 clusters: Forest (vegetation) and Other (rocks/water/bare soil).
cl19 <- im.classify(stack19, num_clusters=2)

# Plotting the classification to visually check the consistency of the results.
plot(cl19, main = "Land Cover Classification 2019")     
     
# Calculating the frequencies to get the percentage of land cover of each land cover class.
f19 <- freq(cl19) # Number of pixels for each class
tot19 <- ncell(cl19) # Total number of pixels in the image
p19 <- f19*100/tot19 # Percentage for each class
p19     
# Class 1 (Forest) = 68.10995%     
# Class 2 (Others) = 31.89005%
     
