library(tidyverse)
library(rvest)
library(chromote)
library(purrr)
library(glue)
library(gt)
library(magrittr)

list_of_items <- c("vial_water","dragon_bones","blankrune","naturerune" ,
                   "irit_leaf","3dose1energy","3dose2energy","iron_knife",
                   "avantoe","harralander","gold_bar","emerald",
                   "ring_of_dueling_8","ranarr_weed","kwuarm","mcannonball",
                   "iron_ore","coal","iron_bar","steel_bar",
                   "yew_logs" , "chocolate_dust","mortmyremushroom","eye_of_newt",
                   "lantadyme","dwarf_weed","cadantine","amulet_of_glory_4",
                   "dragonhide_green", "dragonhide_blue","unidentified_guam")

max_pris <- c(1000,5000,300,500,
              10000,2000,5000,200,
              10000,5000,1000,10000,
              10000,10000,10000,1000,
              1000,1000,1000,2000,
              1000,1500,2000,1000,
              10000,10000,10000,400000,
              4000,5000,3000)


df <- file.info(list.files("PRICE_DATA/3dose1energy/", full.names = T))
forrige_dato <- max(df$mtime)


# dato_grense = today() - 13 #skal være samme dato som siste datautak

dato_grense = forrige_dato 

for(i in 1:length(list_of_items)){
  item_name = list_of_items[i]
  print(item_name)
  
  dir.create(glue("PRICE_DATA/{item_name}") , showWarnings = F)
  
  item_scraping <- function(item,dato_grense){
    
    
    item <- read_html_live(
      glue("https://markets.lostcity.rs/items/{item}"))
    
    item<- item %>% 
      html_nodes("tbody") %>%
      html_table()
    
    recently_sold_item  <- item[[2]] %>%   
      filter(str_detect(X1,"ea")) %>% 
      select(-X2,-X4,-X5) %>% 
      separate_wider_delim(X1, delim = "for" , names =c("antall","pris")) %>% 
      mutate(pris_k = if_else(str_detect(pris, "K"),1,0)) %>% 
      mutate(antall_k = if_else(str_detect(antall, "K"),1,0)) %>%
      mutate(pris = str_remove(pris,"K?\\sea\\.$")) %>% 
      mutate(pris = as.double(pris)) %>% 
      mutate(pris = if_else(pris_k == 1 , 1000*pris,pris)) %>% 
      mutate(antall = str_remove(antall,"K?$")) %>% 
      mutate(antall = str_remove(antall, "^\\[S?B?\\]\\s")) %>% 
      mutate(antall = as.double(antall)) %>% 
      mutate(antall = if_else(antall_k == 1 , antall * 1000 , antall)) %>%
      mutate(tid_month = if_else(grepl("mo",X3),1,0)) %>% 
      mutate(X3 = case_when(grepl("hr" , X3) ~ "0" ,
                            grepl("min" , X3) ~ "0",
                            grepl("day" , X3) ~ str_extract(X3, "[1-9][0-9]?") ,
                            grepl("mo",X3) ~ str_extract(X3, "[1-9]"))) %>%
      mutate(X3 = as.double(X3)) %>%
      mutate(X3 = if_else(tid_month == 1 , 30 * X3 , X3)) %>% 
      mutate(TODAY = today()) %>%
      mutate(date = TODAY - X3) %>%
      filter(date > dato_grense) %>% 
      filter(pris < max_pris[i]) %>% 
      filter(pris > 10) %>% 
      select(antall,pris,date) 
  
    
    return(recently_sold_item)
  }
  
  
  item_df <- item_scraping(item_name,dato_grense = dato_grense) 
  
  today <- today()
  
  write_rds(item_df, file = glue(
    "PRICE_DATA/{item_name}/{item_name}_{today}.rds"))

}




