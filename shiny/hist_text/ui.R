library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                textInput(inputId="main", 
                          label="Texto para o título:",
                          value=""),
                textInput(inputId="sub", 
                          label="Texto para o subtítulo:",
                          value="")
            ),
            mainPanel(
                plotOutput("hist.reactive")
            )
        )
    )
)
