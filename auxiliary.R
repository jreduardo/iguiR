##=============================================================================
## Pacote R do projeto iguir para facilitar a disponibilização e
## utilização das funções elaboradas. Este pacote também objetiva
## facilitar a execução das funções na apresentação do minicurso.

## O pacote foi construído pela biblioteca roxygenise e os arquivos que
## o originaram ainda não foram disponibilizados no repositório remoto
## github
##=============================================================================

##--------------------------------------------
## Instando o pacote
install.packages("iguir_0.1.tar.gz")

##--------------------------------------------
## Requisição do pacote 
require(iguir)
help(package="iguir", h="html")

##--------------------------------------------
## Utilização da função base
help(iguir, h="html")

## Exibindo os tópicos e pacotes
iguir()

## Interfaces interativas
iguir(topic = "select", package = "rpanel")
iguir(topic = "select", package = "shiny")
## Interrompa o processamento R ao fechar a janela do navegador
iguir(topic = "select", package = "gwidgets")
iguir(topic = "listbox", package = "shiny")
## Interrompa o processamento R ao fechar a janela do navegador
iguir(topic = "text", package = "rpanel")


##=============================================================================
## Foram incluídos no pacote somente as interfaces consideradas "toy"
