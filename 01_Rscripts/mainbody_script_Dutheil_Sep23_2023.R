# Script file for mini-project assignment in Productivity & Reproducibility in Ecology and Evolution
# Author: Laura Dutheil
# Date created: September 22, 2023
# Last updated: September 22, 2023

# install.packages("tidyverse")
library(tidyverse)
# install.packages("tidyverse")
library(palmerpenguins)

dataset <- palmerpenguins::penguins
view(dataset)

write_csv(dataset, "./00_rawdata/palmerpenguins.csv")
