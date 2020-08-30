# necessary libraries
library(tidyverse)
library(rgdal)
library(sf)
library(raster)

# read in both shape files and make sure they have the same CRS
republic = readOGR("Census2011_Province_generalised20m.shp") %>%
  spTransform(CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
north = readOGR("OSNI_Open_Data_-_Largescale_Boundaries_-_County_Boundaries_.shp") %>%
  spTransform(CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

# compine both sp objects into one
ireland <- bind(republic, north)

# cread a grid of points inside the sp
grid =  (spsample(ireland, n = 10000, "regular")) %>% as.data.frame() 

# have a look to see if it worked
ggplot()+
  geom_point(data = grid, aes(x1,x2), size = 0.1) +
  coord_quickmap()
