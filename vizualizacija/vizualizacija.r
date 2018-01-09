# 3. faza: Vizualizacija podatkov
# Graf 
library(ggplot2)
library(dplyr)

# 1.Graf bo prikazoval stopnjo prenaseljenosti v Sloveniji(STOPNJA PRENASELJENOSTI STANOVANJA (2005-2016))

graf1 <- ggplot(data =tabela2, aes(x =Leto, y =(odstotek_oseb),color = Spol ))+
  geom_point(shape=1)+
  geom_smooth(method=lm , color="red", se=TRUE)+
  xlab("Leto") + ylab("Odstotek oseb") +
  ggtitle("Stopnja prenaseljenosti stanovanja (2005-2016)")



# Uvozimo zemljevid.
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(lat > -60)


svet1 <- ggplot()+geom_polygon(data=evropa, aes(x=long, y= lat, group = group))
print(evropa1)


