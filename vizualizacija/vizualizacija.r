# 3. faza: Vizualizacija podatkov
# Graf 
library(ggplot2)
library(dplyr)
library(digest)
library(maptools)

#1.Graf bo prikazoval stopnjo prenaseljenosti v Sloveniji(STOPNJA PRENASELJENOSTI STANOVANJA (2005-2016))
graf1 <- ggplot(data =tabela2, aes(x =Leto, y =(odstotek_oseb),colour = Spol ))+
  geom_point(shape=1)+
  geom_smooth(method=lm , color="red", se=TRUE)+
  xlab("Leto") + ylab("Odstotek oseb") +
  ggtitle("Stopnja prenaseljenosti stanovanja (2005-2016)")

#2.Graf : stanovanjske prikrajsanosti 
naslov_graf2 <- "Stanovanjske prikrajšanosti"
Encoding(naslov_graf2)<- "UTF-8"
oznake <- c("Slabo stanje stanovanja" = "Slabo stanje\nstanovanja",
            "Kad ali prha v stanovanju" = "Kad ali prha\nv stanovanju",
            "Stranišče na izplakovanje za lastno uporabo" = "Stranišče na\nizplakovanje za\nlastno uporabo",
            "Pretemno stanovanje" = "Pretemno stanovanje")
Encoding(oznake) <- "UTF-8"
Encoding(names(oznake)) <- "UTF-8"
status.skupaj <- "Status tveganja revščine -SKUPAJ"
Encoding(status.skupaj) <- "UTF-8"

graf2 <- ggplot(data = tabela1 %>%
                  filter(starost == "Starostne skupine - SKUPAJ",
                         status == status.skupaj,
                         spol != "Spol - SKUPAJ"),
                aes(x = leto, y = stopnja, fill = spol))+
  geom_col(position = "dodge") +
  facet_grid(. ~ oznake[element], space = "free")+
  ggtitle(naslov_graf2)

#3.Graf: samoocene splosnega zadovoljstva življenja
naslov_graf3 <- "Samoocena splošnega zadovoljstva življenja"
Encoding(naslov_graf3)<-"UTF-8"
graf3 <- ggplot(data = tabela_zadovoljstvo, aes(x=leto, y = odstotek, colour = ocena ))+ 
  geom_line()+
  xlab("Leto") + ylab("Odstotek") +
  ggtitle(naslov_graf3)


#4.Graf : Breme stanovanjskih stroškov
naslov_graf4 <- "Breme stanovanjskih stroškov"
Encoding(naslov_graf4)<- "UTF-8"
graf4 <- ggplot(data = breme_stanovanjskih_stroskov,
                aes(x = leto, y = odstotek, color = velikost.bremena)) +
  geom_line() + facet_grid(. ~ gospodinjstvo) + xlab("Leto") + ylab("Odstotek") +
  ggtitle(naslov_graf4) + guides(color = guide_legend("Velikost bremena")) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

#4.2 Graf: delež prebivalcev katerim stanovanjski stroški predstavljajo preveliko breme:
naslov_graf42 <- "Delež prebivalcev katerim stanovanjski stroški predstavljajo preveliko breme"
Encoding(naslov_graf42)<- "UTF-8"
graf42 <- ggplot(data= delez, aes(x =leto, y = stopnja))+
  geom_line()+
  facet_grid(. ~ drzava)+
  ggtitle(naslov_graf42)


graf123 <- ggplot(data = delez %>% filter(drzava == "Slovenia"),
                  aes(x = leto, y = stopnja))+
  geom_point() 
#5.Graf: Stopnje prenaseljenosti v eu 

graf5 <- ggplot(data= prenaseljenost, aes(x = timegeo, y = stopnja))+
  geom_col() + facet_grid(. ~ leto)


# Uvozimo zemljevid.
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                        "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>%  filter(CONTINENT %in% c("Europe"))

#NASLOVA
naslov <- "Stopnja prenaseljenosti za moške v Evropi"
Encoding(naslov) <- "UTF-8"
naslov2 <- "Stopnja prenaseljenosti za ženske v Evropi"
Encoding(naslov2)<- "UTF-8"
#ZEMLJEVID: Stopnja prenaseljenosti za moske
zemljevid_moski <-ggplot() + geom_polygon(data = prenaseljenost%>% filter(spol == "moski", leto == "2016") %>% 
                                            mutate(SOVEREIGNT = parse_factor(timegeo,levels(svet$SOVEREIGNT)))%>%
                                            right_join(svet, by = c("timegeo" = "NAME_LONG")),
                                          aes(x= long, y = lat,
                                              group = group,
                                              fill = stopnja)) +
  coord_cartesian(xlim = c(-22, 40), ylim = c(30, 70)) +
  ggtitle(naslov)
# ZEMLJEVID: Stopnja prenaseljenosti za ženske

zemljevid_zenske <-ggplot() + geom_polygon(data = prenaseljenost%>% filter(spol == "zenske", leto == "2016") %>% 
                                             mutate(SOVEREIGNT = parse_factor(timegeo,levels(svet$SOVEREIGNT)))%>%
                                             right_join(svet, by = c("timegeo" = "NAME_LONG")),
                                           aes(x= long, y = lat,
                                               group = group,
                                               fill = stopnja)) +
  coord_cartesian(xlim = c(-22, 40), ylim = c(30, 70)) +
  ggtitle(naslov2)





