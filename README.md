# Analiza podatkov s programom R, 2017/18

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Tematika

Izbrala sem  temo stanovanjski pogoji v Sloveniji. Analizirala bom podatke o stanovanjskih razmerah, prikrajšanosti in prenaseljenosti. V končni fazi bom primerjala Slovenijo in ostale evropske države.

Podatki so v obliki CSV in HTML.
Vir podatkov: http://pxweb.stat.si/pxweb/Database/Dem_soc/Dem_soc.asp



1.Tabela : Breme stanovanjskih stroškov za gospodinjstva, glede na dohodek.
Podatke bom analizirala za leto 2014, 2015 in 2016. Podatki bodo: 
* kvantil (gospodinjstva razdelimo na 5 različnih kvantilov glede na dohodek)
* kakšno breme predstavljajo stanovanjski stroški v deležih ( veliko, srednje, malo) 

2. Tabela: Stopnja prenaseljenosti stanovanja. To je odstotek oseb, ki živijo v stanovanjih s premajhnim številom sob glede na število članov gospodinjstva, zato bom v tabelo vključila podatke :
*delež oseb v prenaseljenih stanovanjih 
*socialni položaj

3.Tabela : Stopnja stanovanjske prikrajšanosti glede na elemente prikrajšanosti. Analizirala bom podatke odstotkov oseb glede na spol, starostno skupino in glede na socialni položaj, ki so prikrajšane za posamezni element stanovanjske prikrajšanosti. 
Vrstice bodo predstavljale : 
*starostno skupino 
*spol

Stolpci pa bodo predstavljali:
*socialni položaj(nad pragom tveganja revščine/pod pragom tveganja revščine)


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
