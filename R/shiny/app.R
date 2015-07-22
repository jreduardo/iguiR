##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## shiny

library(shiny)

x <- precip
a <- extendrange(x, f=0.05)

ui <- fluidPage(
    sidebarPanel(
        sliderInput(inputId="nclass",
                    label="Número de classes:",
                    min=1, max=30, step=1, value=10)
        ),
    mainPanel(
        plotOutput("hist.reactive")
        )
    )

server <- function(input, output) {
    output$hist.reactive <- renderPlot({
        bks <- seq(a[1], a[2], length.out=input$nclass+1)
        hist(x, breaks=bks)
    })
}

shinyApp(ui = ui, server = server)

