library(tidyverse)
library(rvest)
library(chromote)
library(purrr)
library(glue)
library(gt)
library(magrittr)
library(ggpubr)


list_of_items <- c("vial_water","dragon_bones","blankrune","naturerune" ,
                   "irit_leaf","3dose1energy","3dose2energy","iron_knife",
                   "avantoe","harralander","gold_bar","emerald",
                   "ring_of_dueling_8")

plot_list = list()

for(i in 1:length(list_of_items)){
  item_name = list_of_items[i] 
  
  files_in_folder <- list.files(glue("PRICE_DATA/{item_name}/")) 
 
  file.remove(glue("PRICE_DATA/{item_name}/{files_in_folder[2]}"))
  
   
}
  