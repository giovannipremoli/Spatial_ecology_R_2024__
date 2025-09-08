# the presentation is on the professor's account -> in situ data collection, multivariate analysis, dimensionality -> 04 
# hyper-niche o nicchia -> environment with the best condition for a specie 
# our brain can only see 3 dimensions, so a fourth plot is not addable. We need to compact the datas. For instance, let's reduce 3 dimensions to 2 dimensions
# for doing that we have to imagine to solve a cube into a foldable paper 
# let's imagine an hypercube, an immaginary cube that solves himself in 4 dimensions, and aplly this cube in the solved cube in 2 dimensions -> there's a paint with jesus on an hypercube cross
# let's draw 2 axis with some points that are on the bisettrice or nearby that. The points information are 50% given by the axis 1 and 50% by the axis 2. If we draw the bisettrice that's our Component 1 and his axis will be Component 2. In this situation 90% of the information are given by Component1 and only 10% are given by Component2. That's an example fo PCA -> Principal Component Analysis, and in this case the principal is Component1
# N.B. it's not a bisettrice, but the compact data rappresentation. It will not always be that straight and precise 

# Code for multivariate analysis of species x plot data in communities 

install.packages("vegan")
library(vegan) 

data(dune)
data # for obtaining the matrix

head(dune) # to show only the first 6 plots, so it's more compact
View(dune)

# decorana function analysis in R, it's useful when the datas are dispersed
# Analysis
multivar <- decorana(dune) # dune is our dataset
multivar 

# the lenght of axis rappresent the amount of range variability represented by the axis, the aim is to see the percentage of original range variability incorporated in 2 axis 
# we can use maximum 3 axis cause our brains work in 3 dimensions 
dca1 = 3.7004
dca2 = 3.1166
dca3 = 1.30055
dca4 = 1.47888

total = dca1 + dca2 + dca3 + dca4

total 
[1] 9.59643

# Proportions 
prop1 = dca1/total
prop2 = dca2/total 
prop3 = dca3/total
prop4 = dca4/total

# Percentages
perc1 = prop1*100
perc2 = prop2*100
perc3 = prop3*100
perc4 = prop4*100

# now we want a graph in 2 dimensions 
# whole ammount of variability in percentage, cause we only have 2 dimensions. Ci accontentiamo di avere il 71,5% di variabilità per adattarlo a 2 dimensioni
perc1 + perc2
# the first two axes rappresent the 71,5% of the variability

plot(multivar)
# salix that is in top right lives alone, the species that are in the bottom left square live frequently together. In general species that are near in the graph
