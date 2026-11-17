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
  
  df$date <- as.Date(df$date)
  
  return(df)
  
}

df <- overall_ranks_and_dates(data_list = data_list) 
 
df




ggplot(data = df , aes(x = date, y = overall_rank)) + 
  geom_line(aes(group = 1), linewidth = 1.5, colour = "red") +
  geom_point() +
  theme_bw() + ylab("Overall rank") +
  scale_x_date()


ggsave("Overall rank.png", width = 6, height = 8)











