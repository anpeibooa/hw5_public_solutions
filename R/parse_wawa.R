library(tidyverse)

all_wawa <- readRDS(file = "data/wawa/all_wawa_stores.rds")

pluck_coordinates <- function(x) {
  coord <- x$addresses$loc %>% 
    unlist()
  
  tibble(lat = coord[1], lon = coord[2])
}

features <- c("locationID", "areaManager", "addressUrl", "telephone")

wawa <- map(all_wawa, `[`, features) %>% 
  map(unlist) %>% 
  map_dfr(bind_rows) %>% 
  bind_cols(map_dfr(all_wawa, pluck_coordinates))

saveRDS(wawa, file = "data/wawa/wawa.rds")
