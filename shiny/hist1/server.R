library(shiny)

shinyServer(function(input, output) {
    output$hist.reactive <- renderPlot({
        x <- precip
        hist(x,
             col=paste0("#", input$html),
             breaks=input$sl,
             main=NULL,
             ylab="Frequência absoluta",
             xlab="Precipitação")
        if(input$rg){
            rug(x)
        }
    })
})
