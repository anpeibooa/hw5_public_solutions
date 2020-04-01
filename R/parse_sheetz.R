library(tidyverse)

all_sheetz <- readRDS(file = "data/sheetz/all_sheetz_stores.rds")

features <- c("storeNumber", "address", "city", "state", "zip",
              "latitude", "longitude")
sheetz <- map_df(all_sheetz, `[`, features) %>% 
  map(unlist) %>% 
  as_tibble()

saveRDS(sheetz, file = "data/sheetz/sheetz.rds")
