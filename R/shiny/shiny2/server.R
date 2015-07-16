library(shiny)

x <- precip
a <- extendrange(x, f=0.05)
col <- c(Turquesa="#00CC99",
         Azul="#0066FF",
         Rosa="#FF3399",
         Laranja="#FF6600",
         Roxo="#660066",
         "Verde limão"="#99FF33")


shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            bks <- seq(a[1], a[2], length.out=input$nclass+1)
            hist(x, breaks=bks, col = input$color)
        })
    })
