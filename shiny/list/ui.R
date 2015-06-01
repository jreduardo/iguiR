# scp -r hist_* iguir@200.17.213.89:/home/iguir/ShinyApps

# setwd("~/ShinyApps/list")
## Url da servidora para ir para os exemplos, prefixo do endereço.
url <- "http://200.17.213.89:3838"

## Nome do usuário, compõe o link.
user <- Sys.info()["user"]

## Lista de exemplos básicos.
basic <- 
c("hist1", "hist2", "hist_button", "hist_checkbox", 
  "hist_checkboxgroup", "hist_numeric", "hist_radio", "hist_select", 
  "hist_select2", "hist_slider", "hist_text", "outputHTML", 
  "outputTable", "outputVerbatim", "transform")

basic.list <- lapply(basic,
                     function(x){
                         do.call(tags$a,
                                 c(list(
                                     href=paste(url, user, x, sep="/"),
                                     target="_blank"),
                                   x))
                     })

## Lista de exemplos intermediários.
inter <- 
c("distProb", "teoLimCentral", "testHipFlipCoin")

inter.list <- lapply(inter,
                     function(x){
                         do.call(tags$a,
                                 c(list(
                                     href=paste(url, user, x, sep="/"),
                                     target="_blank"),
                                   x))
                     })

## Path do css.
css <- ifelse(Sys.info()["nodename"]=="academia",
              yes="../palatino.css",
              no="/home/walmes/Dropbox/shiny/palatino.css")

## Interface.
shinyUI(
    fluidPage(
        includeCSS(css),
        fluidRow(
            headerPanel("Aplicações em Shiny do grupo IguiR"),
            p("Material desenvolvido para o curso de interfaces gráficas com o R durante a 60 RBRAS em Presidente Prudente, SP."),
            hr(),
            h4("Exemplos básicos (toy examples)"),
            tags$ol(lapply(basic.list, tags$li)),
            h4("Exemplos intermediários"),
            tags$ol(lapply(inter.list, tags$li)),
            h4("Exemplos avançados"),
            hr()
        )
    ))
