library(tidyverse)
library(rvest)
library(jsonlite)

home_url <- "http://www2.stat.duke.edu/~sms185/data/fuel/bystore/zteehs/regions.html"

sheetz_home <- read_html(home_url)

section_urls <- sheetz_home %>% 
  html_nodes(".col-md-2 a") %>% 
  html_attr(name = "href") %>% 
  .[str_detect(string = ., pattern = "PAfuelPrice")]


get_sheetz_store <- function(url) {
  read_html(url) %>% 
    html_nodes("body") %>% 
    html_text() %>% 
    str_remove_all("\\n") %>% 
    fromJSON()
  
  #Sys.sleep(1)
}

all_sheetz_stores <- map(section_urls, get_sheetz_store)
saveRDS(all_sheetz_stores, file = "data/sheetz/all_sheetz_stores.rds")

