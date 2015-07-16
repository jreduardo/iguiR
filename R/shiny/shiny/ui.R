## library(shiny)

shinyUI(
    fluidPage(
            sidebarPanel(
                sliderInput(inputId="nclass",
                            label="Número de classes:",
                            min=1, max=30, step=1, value=10)
            ),
            mainPanel(
                plotOutput("hist.reactive")
            )
    )
)
