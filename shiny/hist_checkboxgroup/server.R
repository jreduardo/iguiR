library(shiny)

x <- precip
ht <- hist(x)
nc <- length(ht$counts)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            seqcol <- colorRampPalette(input$colors)
            plot(ht, col=seqcol(nc),
                 main=NULL,
                 ylab="Frequência absoluta",
                 xlab="Precipitação")
        })
    })
