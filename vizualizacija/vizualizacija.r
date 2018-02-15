# 3. faza: Vizualizacija podatkov
# Graf 
library(ggplot2)
library(dplyr)
library(digest)

# 1.Graf bo prikazoval stopnjo prenaseljenosti v Sloveniji(STOPNJA PRENASELJENOSTI STANOVANJA (2005-2016))

graf1 <- ggplot(data =tabela2, aes(x =Leto, y =(odstotek_oseb),colour = Spol ))+
  geom_point(shape=1)+
  geom_smooth(method=lm , color="red", se=TRUE)+
  xlab("Leto") + ylab("Odstotek oseb") +
  ggtitle("Stopnja prenaseljenosti stanovanja (2005-2016)")

# Graf : stanovanjske prikrajsanosti 
graf2 <- ggplot(data =tabela1, aes(x= leto, y = stopnja, colour = spol)) + 
  geom_col() +
  facet_grid(. ~ element)


# Graf: samoocene splosnega zadovoljstva življenja

graf3 <- ggplot(data = tabela_zadovoljstvo, aes(x=leto, y = odstotek, colour = ocena ))+ 
  geom_line()+
  xlab("Leto") + ylab("Odstotek") +
  ggtitle("Samoocena splošnega zadovoljstva življenja")


# Graf : Breme stanovanjskih stroškov
graf4 <- ggplot(data = breme_stanovanjskih_stroskov, aes(x = leto, y= odstotek, color=factor(velikost.bremena)) )+
  geom_col() +
  facet_grid(. ~ gospodinjstvo)+
  xlab("Leto")+ ylab("Odstotek") +
  ggtitle("Breme stanovanjskih stroškov")+
  guides(color = guide_legend("Velikost bremena"))

# Graf: Stopnje prenaseljenosti v eu 

graf5 <- ggplot(data= prenaseljenost, aes(x = timegeo, y = stopnja))+
  geom_col() + facet_grid(. ~ leto)


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


