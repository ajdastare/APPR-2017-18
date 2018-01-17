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
  pretvori.zemljevid() %>%  filter(CONTINENT %in% c("Europe"))
  


zemljevid_drzav <-ggplot() + geom_polygon(data = prenaseljenost %>% 
                                      mutate(SOVEREIGNT = parse_factor(timegeo,levels(svet$SOVEREIGNT)))%>%
                                      right_join(svet, by = c("timegeo" = "NAME_LONG")),
                                    aes(x= long, y = lat,
                                        group = group,
                                        fill = stopnja)) +
  coord_cartesian(xlim = c(-22, 40), ylim = c(30, 70)) +
  ggtitle("Stopnja prenaseljenosti v Evropi")





# 
# # svet1 <- ggplot()+geom_polygon(data=svet, aes(x=long, y= lat, group = group))
# # print(svet1)
# 
# #rada bi dala podatke iz tabele prenaseljenosti v zemljeviud
# 
# prenaseljenost_moski <- prenaseljenost %>% filter(spol == "moski", stopnja != "NA")
# 
# prenaseljenost_zenske <- prenaseljenost %>% filter(spol == "zenske", stopnja != "NA")
# 
# #odstranla podatke z vrednostjo NA 
# # zemljevid2 <-ggplot() + aes(x = long, y=lat, group= group, fill= stopnja ) + geom_polygon(data = svet %>% filter(CONTINENT == "Europe" |
# #                                                                                                                    SOVEREIGNT %in% c("Canada",
# #                                                                                                                                      "United States of America")))
# print(zemljevid2)


