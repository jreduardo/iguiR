library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                checkboxInput(inputId="rg", 
                              label="Marcar sobre eixo com os valores?",
                              value=FALSE),
                checkboxInput(inputId="modal", 
                              label="Destacal a classe modal?",
                              value=FALSE)
            ),
            mainPanel(
                plotOutput("hist.reactive")
            )
        )
    )
)
