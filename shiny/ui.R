library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Prenaseljenost stanovanja"),
  
  tabsetPanel(
      tabPanel("Država",
               sidebarPanel(
                 selectInput("drzava",
                             label = "Izberite državo",
                             choices = sort(unique(prenaseljenost$timegeo)),
                             selected = "Slovenia"),
                 mainPanel(plotOutput("zemljevid_drzav")),
                 selectInput("spol",
                             label = "Izberite spol",
                             choices = sort(unique(prenaseljenost$spol))
                 )
                 )
      ))
)))



  #              
  #     tabPanel("Breme stanovanjskih stroškov",
  #              sidebarPanel(
  #                selectInput("gospodinjstvo",
  #                            label = "Izberite gospodinjstvo",
  #                            choices = sort(unique(breme_stanovanjskih_stroskov$gospodinjstvo),
  #                                           mainPanel(plotOutput("graf4"))
  #                                           )
  #                  
  #                )
  #              )
  #       
  #     )
  #     )
  # )))
  
