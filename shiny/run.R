##=============================================================================
## Visualizando Aplicacoes (computador local)
##    * runApp
##=============================================================================

require(shiny)

## Lista de Aplicações
dir()[file.info(dir())$isdir]

## Executando as aplicações
runApp("hist2", display.mode = "auto")

##--------------------------------------------
## Obs.: Como o processamento é local deve-se
## executar as aplicações uma a uma.


