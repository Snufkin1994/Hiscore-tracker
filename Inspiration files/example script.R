#example script


# Package LibPath Version Priority Depends Imports LinkingTo
# Suggests Enhances License License_is_FOSS
# License_restricts_use OS_type Archs MD5sum NeedsCompilation
# Built Published

library(httr)
library(jsonlite)


#exaMPLE 1
base_url <- "www.fueleconomy.gov/ws/rest/"

info_url <-  "fuelprices"

full_url <- base::paste0(base_url,info_url)

full_url

api_call <- httr::GET(full_url)

api_call


api_call$status_code

api_call$content

api_char <- base::rawToChar(api_call$content)

api_JSON <- jsonlite::fromJSON(api_char,flatten = T)


#Example 2

base_url <- "www.fueleconomy.gov/ws/rest/"

info_url <-  "fuelprices"

full_url <- base::paste0(base_url,info_url)

api_call <- httr::GET(full_url)

api_call$status_code