# 4. faza: Analiza podatkov
require(ggplot2)
require(dplyr)


# podatki <- obcine %>% transmute(obcina, povrsina, gostota,
#                                 gostota.naselij = naselja/povrsina) %>%
#   left_join(povprecja, by = "obcina")
# row.names(podatki) <- podatki$obcina
# podatki$obcina <- NULL
# 
# # Število skupin
# n <- 5
# skupine <- hclust(dist(scale(podatki))) %>% cutree(n)
# 

#podatki

veliko_breme <- breme_stanovanjskih_stroskov %>% filter(gospodinjstvo == "SKUPAJ", velikost.bremena == "Veliko breme")
ggplot(veliko_breme, aes(x = leto, y = odstotek)) + 
  geom_line() + geom_smooth(method=lm, se = FALSE) 


#model
m <- lm(data = breme_stanovanjskih_stroskov%>% filter(gospodinjstvo == "SKUPAJ", velikost.bremena == "Veliko breme"),
        odstotek ~ leto )
lin <- predict(m, data.frame(leto = seq(2016,2026)))

#predikcija
n <- data.frame(leto = seq(2016,2026))
napoved <- n %>% mutate(odstotek = lin )
 #izris napovedi
ggplot(veliko_breme, aes(x = leto, y = odstotek)) + geom_line()+
  geom_smooth(method = lm)+
  geom_point(data= napoved, aes(x = leto,y = odstotek),color = 'red', size =2)

summary(lin)



#predikcija za vse velikosti bremen

vsa <- breme_stanovanjskih_stroskov %>% filter(gospodinjstvo == "SKUPAJ")
grafek <- ggplot(vsa, aes(x = leto, y = odstotek, color = velikost.bremena)) + 
  geom_line() 
#model

m_nisobreme <- lm(data = breme_stanovanjskih_stroskov%>% filter(gospodinjstvo=="SKUPAJ", velikost.bremena== "Niso breme"),
                  odstotek ~ leto )
lin_nisobreme <- predict(m_nisobreme, data.frame(leto = seq(2016,2026)))

m_srednjebreme <-lm(data = breme_stanovanjskih_stroskov%>% filter(gospodinjstvo == "SKUPAJ", velikost.bremena=="Srednje veliko breme"),
                    odstotek ~ leto )
lin_srednjebreme <- predict(m_srednjebreme,data.frame(leto = seq(2016,2026)))

m_velikobreme <- m
lin_velikobreme <-lin

                         
#predikcija
napoved2 <- n %>% mutate(odstotek = lin_nisobreme )
napoved3 <- n %>% mutate(odstotek = lin_srednjebreme )
napoved4 <- n %>% mutate(odstotek = lin_velikobreme)

#izris napovedi
napoved_bremen <- ggplot(vsa, aes(x = leto, y = odstotek,color = velikost.bremena)) + geom_line()+
  geom_smooth(method = lm, fullrange = TRUE)+
  geom_point(data= napoved2, aes(x = leto,y = odstotek), color ='red', size =2)+
  geom_point(data = napoved3, aes(x=leto, y=odstotek), color = 'green', size = 2) +
  geom_point(data = napoved4, aes(x= leto, y = odstotek), color ='blue', size= 2)

