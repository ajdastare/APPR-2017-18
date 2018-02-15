library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Prenaseljenost stanovanja"),
  
  tabsetPanel(
      tabPanel("Država",
               sidebarPanel(
                 selectInput("drzava",
                             label = "Izberite državo",
                             choices = sort(unique(prenaseljenost$timegeo)),
                             selected = "Slovenia")),
                 selectInput("spol",
                             label = "Izberite spol",
                             choices = sort(unique(prenaseljenost$spol))
                 )
                 ),
      mainPanel(plotOutput("Graf"))
      
      ))
  )



