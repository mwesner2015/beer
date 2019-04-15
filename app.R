library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)
breweries <- read_csv("data/breweries.csv")
beers <- read_csv("data/beers.csv")

Beer = select(Beer,-X1)

breweries <- read_csv("breweries.csv")
beers <- read_csv("beers.csv")

Beer = select(Beer,-X1)

Cleanbrewery = Brewery %>%
  rename(brewery = name) %>%
  rename(brewery_id = X1) %>%
  mutate(brewery_id = brewery_id + 1)

Cleanbeer = Beer %>%
  rename(beer = name)

Beers = full_join(Cleanbrewery,Cleanbeer, by = 'brewery_id')
Beers
