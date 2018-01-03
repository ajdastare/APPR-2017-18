# 2. faza: Uvoz podatkov
#1. CSV TABELA
#STOPNJA PRENASELJENOSTI STANOVANJA (2005-2016)

sl <- locale(encoding = "Windows-1250", decimal_mark = ".", grouping_mark = ",")
datoteka1 <- "podatki/stopnja_pre1.csv"
stopnja_prenaseljenosti <-read_delim(datoteka1, ";", skip = 4, n_max = 10, trim_ws = TRUE, locale = sl) %>%
  fill(1:2) %>% drop_na(3)
stan.pri <- read_delim(datoteka1, ";", skip = 4, n_max = 10, trim_ws = TRUE, locale = sl) %>%
  fill(1:2) %>% drop_na(3)
stolpci <- read_csv2(datoteka1, skip = 3, n_max = 1, col_names = FALSE,
                     col_types = cols(.default = col_integer())) %>% t() %>%
  cbind(data.frame(colnames(stan.pri) %>% strapplyc("^([^_]+)") %>% unlist())) %>% fill(1) %>%
  apply(1, paste, collapse = "")
stolpci[1:3] <- c("element", "starost", "spol")
colnames(stan.pri) <- stolpci
stan.pri <- melt(stan.pri, value.name = "stopnja", id.vars = 1:3, variable.name = "stolpec") %>%
  mutate(stolpec = parse_character(stolpec)) %>%
  transmute(leto = stolpec %>% strapplyc("^([0-9]+)") %>% unlist() %>% parse_number(),
            status = stolpec %>% strapplyc("([^0-9]+)$") %>% unlist() %>% factor(),
            element, starost, spol, stopnja)


#2.CSV TABELA -STANOVANJSKA PRIKRAJSANOST

datoteka2 <- "podatki/stanovanjska_prikrajsanost.csv"
stan.pri <- read_delim(datoteka2, ";", skip = 4, n_max = 68, trim_ws = TRUE, locale = sl) %>%
  fill(1:2) %>% drop_na(3)
stolpci <- read_csv2(datoteka2, skip = 3, n_max = 1, col_names = FALSE,
                     col_types = cols(.default = col_integer())) %>% t() %>%
  cbind(data.frame(colnames(stan.pri) %>% strapplyc("^([^_]+)") %>% unlist())) %>% fill(1) %>%
  apply(1, paste, collapse = "")
stolpci[1:3] <- c("element", "starost", "spol")
colnames(stan.pri) <- stolpci
stan.pri <- melt(stan.pri, value.name = "stopnja", id.vars = 1:3, variable.name = "stolpec") %>%
  mutate(stolpec = parse_character(stolpec)) %>%
  transmute(leto = stolpec %>% strapplyc("^([0-9]+)") %>% unlist() %>% parse_number(),
            status = stolpec %>% strapplyc("([^0-9]+)$") %>% unlist() %>% factor(),
            element, starost, spol, stopnja)


# uvozi.stanovanjska_prikrajsanost <- function(){
# stanovanjska_prikrajsanost <- read.csv2(file = "stanovanjska_prikrajsanost.csv", header = FALSE, sep=";")
# stanovanjska_prikrajsanost <- stanovanjska_prikrajsanost[-c(73:98),]
# stanovanjska_prikrajsanost<- stanovanjska_prikrajsanost[-c(1:2),]
# View(stanovanjska_prikrajsanost)
# 
# }
# 

# stopnja_p <- apply(obsojeni,2, function(x) gsub("-",NA,x))

# 
# sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# 3.HTML TABELA


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


