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
                   "yew_logs")

max_pris <- c(1000,5000,300,500,
              10000,NA,NA,NA,)
 