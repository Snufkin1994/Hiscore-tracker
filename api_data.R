#tracking hiscore progress to Snufkin HC

library(httr)
library(jsonlite)
library(tidyverse)
library(glue)

today <- today()

base_url <- "https://secure.runescape.com/m=hiscore_oldschool_hardcore_mains/"

info_url <-  "index_lite.json?player=Snufkin_HC"

full_url <- base::paste0(base_url,info_url)

api_call <- httr::GET(full_url)

api_call$status_code

api_call$content

api_char <- base::rawToChar(api_call$content)

api_JSON <- jsonlite::fromJSON(api_char,flatten = T)

api_JSON

df_skills <- api_JSON$skills

write_rds(df_skills,glue("C:/HC_worlds/Hiscore tracker/Data/Skills/{today}.rds"))

df_activites <- api_JSON$activities

write_rds(df_activites,glue("C:/HC_worlds/Hiscore tracker/Data/Activities/{today}.rds"))






