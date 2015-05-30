library(shiny)

ht <- hist(precip)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            input$acao
            col <- sample(colors(), size=1)
            plot(ht, main=NULL,
                 ylab="Frequência absoluta", xlab="Precipitação",
                 col=col, sub=col)
        })
    })
