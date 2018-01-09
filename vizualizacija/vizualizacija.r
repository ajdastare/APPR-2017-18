# 3. faza: Vizualizacija podatkov
# Graf 
library(ggplot2)
library(dplyr)

# 1.Graf bo prikazoval stopnjo prenaseljenosti v Sloveniji(STOPNJA PRENASELJENOSTI STANOVANJA (2005-2016))

ggplot(data =tabela2, aes(x =Leto, y =(odstotek_oseb) )) + geom_point()





# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
                             "OB/OB", encoding = "Windows-1250")
levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
zemljevid <- pretvori.zemljevid(zemljevid)

# Izračunamo povprečno velikost družine
povprecja <- druzine %>% group_by(obcina) %>%
  summarise(povprecje = sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))
