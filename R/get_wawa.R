library(tidyverse)
library(rvest)
library(jsonlite)


fromJSON_safely <- safely(fromJSON)
store_numbers <- str_pad(c(1:1000, 8000:9000), width = 5, pad = "0")

# choose method 1 or method 2; method 2 will be easier with make

# method 1: get each individual store and save
get_wawa_store <- function(store_num) {
  
  base_url <- "http://www2.stat.duke.edu/~sms185/data/fuel/bystore/awaw/awawstore="
  url <- str_c(base_url, store_num, ".json")
  
  x <- fromJSON_safely(url)
  
  if (!is.null(x$result)) {
    write_json(x$result, str_c("data/wawa/", store_num, ".json"))
  }
  
  #Sys.sleep(1)
  
}

# uncomment if you want to use method 1
# walk(store_numbers, get_wawa_store)


# method 2: combine all stores and save
get_wawa_stores <- function(store_num) {
  
  base_url <- "http://www2.stat.duke.edu/~sms185/data/fuel/bystore/awaw/awawstore="
  url <- str_c(base_url, store_num, ".json")
  
  x <- fromJSON_safely(url)
  if (!is.null(x$result)) { return(x$result) }
  
  #Sys.sleep(1)
}

# only 10 stores to speed things up
wawa_stores <- map(store_numbers[1:10], get_wawa_stores) %>% 
  discard(is.null)

saveRDS(wawa_stores, file = "data/wawa/all_wawa_stores.rds")
