library(obistools)
library(tidyverse)

# read published tsv from google sheet
df <- read_delim("https://docs.google.com/spreadsheets/d/e/2PACX-1vTei7SwuwPhXU1pYD_QU3nANM5JXjZW6ti-gt2BjVFoq0mqPcrXdVDXXeF2L2etG_gbuQXz53KSfI4H/pub?gid=0&single=true&output=tsv", delim = "\t")

# create a data frame with footprintwkt and its coordinateUncertaintyInMeters
uncertainty <- df %>% filter(is.na(End_Lat)==FALSE) %>%  
  select(footprintWKT) %>%
  mutate(coordinateUncertaintyInMeters = calculate_centroid(footprintWKT)$coordinateUncertaintyInMeters)

# write the data frame into file
write_delim(uncertainty, "data/generated/uncertainty.txt", delim="\t", na="")
