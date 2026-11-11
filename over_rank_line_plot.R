#plot overall skilling rank 
library(glue)
library(tidyverse)


data_list <- list.files(path = "Data/Skills/")


df <- data.frame(date = NULL , overall_rank = NULL)

overall_ranks_and_dates <- function(data_list = data_list){
  for (i in 1:length(data_list)){
    denne_df <- readRDS(glue("Data/Skills/{data_list[i]}"))
    
    denne_overall_rank <- denne_df$rank[1]
    
    denne_dato <- str_remove(data_list[i],".rds")
    
    denne_df2 <- data.frame(date = denne_dato , 
                            overall_rank = denne_overall_rank)
    
    df <- rbind(df,denne_df2)
  }
  
  
  return(df)
  
}

df <- overall_ranks_and_dates(data_list = data_list) 
 
df


ggplot(data = df , aes(x = date, y = overall_rank)) + 
  geom_line(aes(group = 1)) + 
  geom_point()


ggplot(economics, aes(date, unemploy)) + geom_line()


#test

#ny test :)

