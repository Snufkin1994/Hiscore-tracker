ggplot(alle_item_dfs,) +
  geom_point( aes(x = date, y = pris , size = antall) ) +
  geom_smooth(aes(x = date, y = pris ),method='lm' , se = FALSE ) +
  geom_line(aes(x = date, y =  c(rollmean(pris, 10),rep(500,9) ))) 

          


ggplot(alle_item_dfs,) +
  geom_point( aes(x = date, y = pris , size = antall) ) +
  geom_smooth(aes(x = date, y = pris ),method='lm' , se = FALSE ,
              color = "orange") +
  geom_line(aes(x = date, y = 
                    rollmean(pris, 10,fill = NA,align = "left")),
            color = "red")+
  geom_smooth(aes(x = date, y = 
                    rollmean(pris, 10,fill = NA,align = "left")),se=F) 




weights <- 1:13/sum(1:13)


rollapply(volume_Austin$volume, 
          \(x) sum(weights*x), width = 13, fill = NA, align = "right")