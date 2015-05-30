library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                actionButton(inputId="acao", label="Nova cor!")
            ),
            mainPanel(
                plotOutput("hist.reactive")
            )
        )
    )
)
