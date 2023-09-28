# Script file for mini-project assignment in Productivity & Reproducibility in Ecology and Evolution
# Author: Laura Dutheil
# Date created: September 18, 2023
# Last updated: September 28, 2023


##### Installing packages and loading data #####


install.packages("tidyverse")
library(tidyverse)
install.packages("tidyverse")
library(palmerpenguins)
install.packages("ggplot2")
library(ggplot2)

# Setting our working directory so that this script is stored in the correct folder
setwd("./01_Rscripts")

# Loading the palmer penguin data
PenguinData <- palmerpenguins::penguins
view(PenguinData)
# Writing the data to our file, as we want to preserve the raw data
write_csv(PenguinData, "./00_rawdata/palmerpenguins.csv")


##### Data Cleaning #####


# For this project, we are interested in learning whether penguin body mass varies significantly between different islands. 
# Let's look at how many islands we are working with
unique(PenguinData$island) # There are three islands
unique(PenguinData$body_mass_g) # There are NAs in this column
# Removing instances of NAs in the body_mass_g column, since we will be using this for our analysis.
PenguinDataFiltered <- PenguinData %>% 
  filter(!is.na(body_mass_g))
# Checking:
unique(PenguinDataFiltered$body_mass_g) # No more NAs

# Let's check for outliers in the body mass column 
boxplot(PenguinDataFiltered$body_mass_g,
        ylab = "body_mass_g") # There don't appear to be any outliers 


##### Analysis and Figures #####


# Making a new dataframe which groups the islands by their name and summarises the mean body mass for all the penguins belonging to one island
IslandMass <- PenguinDataFiltered %>% 
  group_by(island) %>% 
  summarise(mean_body_mass = mean(body_mass_g))
# Let's save this dataframe to our output folder for safekeeping
write_csv(IslandMass, "./02_outputdata/Average_mass_by_island.csv")

# Now, let's plot this dataframe so we can visually see the average body mass per island. Our x axis is the Island name, y axis the mean body mass in g. We'll use a light blue colour for the bars and label our axes.
ggplot(IslandMass, aes(x = island, y = mean_body_mass)) +
  geom_bar(stat = "identity", fill = "light blue") +
  labs(x = "Island", y = "Average Body Mass (g)")
# It looks like the Biscoe Island has penguins with a larger body mass than the other two islands. Let's see if this is statistically significant. 
ggsave(filename = "Body_Mass_by_Island.png", plot = last_plot(), path = "./03_figures")

