##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## shiny

## Diretório local
shiny::runApp("shiny")

## Remoto github
shiny::runGitHub("iguiR", "JrEduardo", subdir = "shiny/hist1")

## Arquivos Rmd
rmarkdown::run("relatorio.Rmd")
