library(shiny)

shinyUI(fluidPage(
  
    h3("Distribuição Normal", align = "center"),
    
    h5("Parâmetros da Aplicação", align = "center"),
    fluidRow(
    
        column(4,
               wellPanel(
                   sliderInput(inputId="mu", label="Média",
                               min=1, max=100,
                               step=0.1, value=3)
                   )
               ),
        
        column(4,
               wellPanel(
                   sliderInput(inputId="va", label="Variância",
                            min=0.2, max=3,
                            step=0.05, value=1)
                   )
               ),
        
        column(4,
               wellPanel(
                   sliderInput(inputId="n", label="Números de simulações",
                               min=5, max=300,
                               step=1, value=50)
                   )
               )
        ),
   
    h5("Gráficos Descritivos", align = "center"),
    fluidRow(
        
        column(6, 
               plotOutput("graf1", height = "600px")),
        
        column(6, 
               fluidRow(
                   plotOutput("graf2", height = "300px")),
               fluidRow(
                   plotOutput("graf3", height = "300px")))
        )
    )
)

