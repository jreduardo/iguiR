library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Histograma"),
        sidebarLayout(
            sidebarPanel(
                actionButton("acao", "Nova cor!")
            ),
            mainPanel(
                plotOutput("hist.reactive")
            )
        )
    )
)
