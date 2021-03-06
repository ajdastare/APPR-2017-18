library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  output$prenaseljenost <- renderPlot({
    ggplot(data = prenaseljenost %>% filter(spol == input$spol,
                                            timegeo == input$drzava
    ),
    aes(x = leto, y = stopnja)) +
      geom_col() + ggtitle("Stopnja prenaseljenosti")
  })
  output$delez <- renderPlot({
    ggplot(data = delez %>% filter(drzava == input$drzava),
           aes(x = leto, y = stopnja)) +
      geom_col()+
      ggtitle("Delež prebivalstva katerim so stanovanjski stroški breme")
  })
}    
)






# 
# shinyServer(function(input, output) {
#   output$druzine <- DT::renderDataTable({
#     dcast(druzine, obcina ~ velikost.druzine, value.var = "stevilo.druzin") %>%
#       rename(`Občina` = obcina)
#   })
#   
#   output$pokrajine <- renderUI(
#     selectInput("pokrajina", label="Izberi pokrajino",
#                 choices=c("Vse", levels(obcine$pokrajina)))
#   )
#   output$naselja <- renderPlot({
#     main <- "Pogostost števila naselij"
#     if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$pokrajina)) {
#       t <- obcine %>% filter(pokrajina == input$pokrajina)
#       main <- paste(main, "v regiji", input$pokrajina)
#     } else {
#       t <- obcine
#     }
#     ggplot(t, aes(x = naselja)) + geom_histogram() +
#       ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
#   })
# })
