# 2. faza: Uvoz podatkov
source("lib/libraries.r")
library(reshape2)
#1. CSV TABELA
#STOPNJA PRENASELJENOSTI STANOVANJA (2005-2016)
sl <- locale(encoding = "UTF-8", decimal_mark = ".", grouping_mark = ",")
slwin <- locale(encoding = "Windows-1250", decimal_mark = ".", grouping_mark = ",")

datoteka1 <- "podatki/stopnja_pre1.csv"

stopnja_prenaseljenosti <-read_delim(datoteka1, ";",skip = 3, trim_ws = TRUE, locale = slwin)%>%
  fill(1:2)%>% drop_na(3) %>% melt() %>% mutate(variable = parse_number(variable))
colnames(stopnja_prenaseljenosti)<- c("Kategorija","Vsa gospodinjstva","Spol","Leto","odstotek_oseb")
Encoding(stopnja_prenaseljenosti$Spol) <- "UTF-8"
tabela2 <- stopnja_prenaseljenosti


#melt je dal v stolpce, mutate spremeni leto v število
#trim_ws izbriše white space

#2.CSV TABELA -STANOVANJSKA PRIKRAJSANOST

#datoteka2 <- "podatki/stanovanjska_prikrajsanost.csv"
datoteka2 <- "podatki/0867806Ss.csv"
stan.pri2 <- read_delim(datoteka2, ";", skip = 4, n_max = 68, trim_ws = TRUE, locale=slwin)%>%
  fill(1:2) %>% drop_na(3)
stolpci2 <- read_csv2(datoteka2, skip = 3, n_max = 1, col_names = FALSE,
                      col_types = cols(.default = col_integer()))%>% t()
stolpci3 <- read_csv2(datoteka2, skip = 4, n_max = 1, col_names = FALSE,
                      locale = slwin) %>% t()

Encoding(stolpci3) <- "UTF-8"
stolpci <- data.frame(stolpci2, stolpci3) %>% fill(1) %>% apply(1, paste, collapse = "")
stolpci[1:3] <- c("element", "starost", "spol")
colnames(stan.pri2) <- stolpci
stan.pri2 <- melt(stan.pri2, value.name = "stopnja", id.vars = 1:3, variable.name = "stolpec")%>%
  mutate(stolpec = parse_character(stolpec))%>%
  transmute(leto = stolpec %>% strapplyc("^([0-9]+)") %>% unlist()%>% parse_number(),
            status = stolpec %>% strapplyc("([^0-9]+)$") %>% unlist() %>% factor(),
            element, starost, spol, stopnja)

tabela1 <- stan.pri2 
Encoding(levels(tabela1$status)) <- "UTF-8" # faktor
Encoding(tabela1$spol) <- "UTF-8" # znakovni stolpec
Encoding(tabela1$element) <- "UTF-8"


# 3.HTML TABELA (PRENASELJENOST PO DRŽAVAH)

pre.moski <- read_html("podatki/prenaseljenost_eurostat_moski.htm") %>%
  html_node(xpath="//table[@class='infoData']") %>% html_table() %>%
  melt(value.name = "stopnja", id.vars = "timegeo", variable.name = "leto")


pre.zenske <- read_html("podatki/prenaseljenost_eurostat_zenske.htm") %>%
  html_node(xpath="//table[@class='infoData']") %>% html_table() %>%
  melt(value.name = "stopnja", id.vars = "timegeo", variable.name = "leto")
spoli <- c("moski", "zenske")
pre.moski$spol <- factor("moski", levels = spoli)
pre.zenske$spol <- factor("zenske", levels = spoli)

prenaseljenost <- rbind(pre.moski, pre.zenske) %>% mutate(stopnja = parse_number(stopnja, na = ":"))

# 4. tabela : Zadovoljstvo z življenjem 

sl <- locale(encoding = "Windows-1250", decimal_mark = ".", grouping_mark = ",")
zadovoljstvo <-"podatki/zadovoljstvo2.csv"

tabela_zadovoljstvo <- read_csv2(zadovoljstvo, skip = 4, n_max= 7, trim_ws = TRUE, locale = sl) %>%
  drop_na(3) %>% select(-1, -2) %>% rename(ocena = X3) %>%melt(id.vars = "ocena", variable.name = "leto", value.name = "odstotek") %>%
  mutate(leto = parse_number(leto))
#select(-1,-2)  pobriše prvi in drugi stolpec 

# 5. tabela : breme stanovanjskih stroškov
sl <- locale(encoding = "Windows-1250", decimal_mark = ".", grouping_mark = ",")
stroski<-"podatki/breme_stanovanjskih_stroskov.csv"
breme_stanovanjskih_stroskov <- read_delim(stroski, ";", skip = 3, n_max = 16, trim_ws = TRUE, locale=sl) %>%
  fill(1:2) %>% drop_na(3) %>%
  rename(gospodinjstvo = X1, velikost.bremena = X2)%>%
  melt(id.vars = c("gospodinjstvo", "velikost.bremena"),
       variable.name = "leto", value.name = "odstotek") %>%
  mutate(leto = parse_number(leto))


#5  Delež prebivalcev katerim so stanovanjski stroški preveliko breme 
# delez<- read_html("http://ec.europa.eu/eurostat/tgm/web/_download/Eurostat_Table_tespm140HTMLNoDesc_bb759afd-69f5-4b14-89ed-c115cacfc96d.htm") %>%
#  html_node(xpath="//table[@class='infoData']") %>% html_table() %>%
#   melt(value.name = "stopnja", id.vars = "timegeo", variable.name = "leto")


delez<- read_html("podatki/ilc_lvho07a.html") %>%
  html_node(xpath="//table") %>% html_table()
colnames(delez) <- c("drzava", 2003:2017)
delez <- melt(delez[-nrow(delez), ], value.name = "stopnja", id.vars = "drzava",
              variable.name = "leto") %>%
  mutate(leto = parse_number(leto),
         stopnja = parse_number(stopnja, na = ":")) 
# sem gre datoteka ilc_lvho07a
za2016 <- delez %>% filter(leto == "2016")

