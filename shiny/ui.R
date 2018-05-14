library(shiny)


shinyUI(fluidPage(
  
  titlePanel("Prenaseljenost stanovanja in delež prebivalcev katerim stanovanjski stroški predstavljajo breme"),
  
  tabsetPanel(
    tabPanel("Država",
             sidebarPanel(
               selectInput("drzava",
                           label = "Izberite državo",
                           choices = sort(unique(prenaseljenost$timegeo)),
                           selected = "Slovenia"),
               selectInput("spol",
                           label = "Izberite spol",
                           choices = sort(unique(prenaseljenost$spol))
               )
             ),
             mainPanel(plotOutput("prenaseljenost"),
                       mainPanel(plotOutput("delez"))
                       
             ))
  )))
# titlePanel( "Delež prebivalcev katerim so stanovanjski stroški preveliko breme" ),
# 
# tabsetPanel(
#   tabPanel("Država",
#            sidebarPanel(
#              selectInput("drzava",
#                          label = "Izberite državo",
#                          choices = sort(unique(delez$drzava))

#          )),
#          mainPanel(plotOutput("delez"))
# ))



