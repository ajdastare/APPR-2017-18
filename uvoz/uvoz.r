# 2. faza: Uvoz podatkov
#1. CSV TABELA
stanovanjska_p <- read.csv(file="stopnja_pre.csv",skip = 3, header=TRUE, sep=",")
stanovanjska_p <- apply(stanovanjska_p,2, function(x) gsub(";","",x))



#2.CSV TABELA 
stopnja_p <- read.csv(file = "stopnja_prenaseljenosti.csv", header = TRUE, sep=",")

stopnja_p <- apply(obsojeni,2, function(x) gsub("-",NA,x))

# 
# sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")
# 
# # Funkcija, ki uvozi občine iz Wikipedije
# uvozi.prenaseljenost_m <- function() {
#   link <- "http://ec.europa.eu/eurostat/tgm/web/_download/Eurostat_Table_tessi170HTMLDesc_2ea2adcf-304b-4844-a32a-5d756878ea72.htm"
#   stran <- html_session(link) %>% read_html()
#   tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
#     .[[1]] %>% html_table(dec = ",")
#   for (i in 1:ncol(tabela)) {
#     if (is.character(tabela[[i]])) {
#       Encoding(tabela[[i]]) <- "UTF-8"
#     }
  }
  # colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
  #                       "ustanovitev", "pokrajina", "regija", "odcepitev")
  # tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  # tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  # tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  # for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
  #   tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)
  # }
  # for (col in c("obcina", "pokrajina", "regija")) {
  #   tabela[[col]] <- factor(tabela[[col]])
  
  return(tabela)
}

# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvozi.druzine <- function(obcine) {
#   data <- read_csv2("podatki/druzine.csv", col_names = c("obcina", 1:4),
#                     locale = locale(encoding = "Windows-1250"))
#   data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
#     strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist()
#   data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
#   data <- data %>% melt(id.vars = "obcina", variable.name = "velikost.druzine",
#                         value.name = "stevilo.druzin")
#   data$velikost.druzine <- parse_number(data$velikost.druzine)
#   data$obcina <- factor(data$obcina, levels = obcine)
#   return(data)
# }

# # Zapišimo podatke v razpredelnico obcine
# obcine <- uvozi.obcine()
# 
# # Zapišimo podatke v razpredelnico druzine.
# druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
