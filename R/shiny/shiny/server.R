library(shiny)

x <- precip
a <- extendrange(x, f=0.05)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            bks <- seq(a[1], a[2], length.out=input$nclass+1)
            hist(x, breaks=bks)
        })
    })
