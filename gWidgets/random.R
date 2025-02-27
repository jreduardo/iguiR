##=============================================================================
## Interface para exibição do método da transformação integral de
## probabilidade, são gerados numeros aletorios da distribuição
## exponencial
## widgets:
##    * Button
##=============================================================================

##-----------------------------------------------------------------------------
## Definições da sessão.
require(gWidgets)
require(gWidgetstcltk)
options(guiToolkit="tcltk")

## Gerando valores de uma v.a X com distribuição exponencial de
## parametro lambda a partir de valores de uma uniforme
set.seed(2015)
lambda <- 0.5
u <- runif(10)
x <- log( 1 - u ) / - lambda

##-----------------------------------------------------------------------------
## Função iterativa/reativa
anima <- function(...){
    layout(matrix(c(1,1,1,2,3,4), ncol=3, by=TRUE))
    for (i in 1:length(u)) {
        ## Velocidade da animação
        Sys.sleep( time = time )
        ## ---- Gráfico 1
        ## Média e desvio padrão
        mean <- mean(x[1:i])
        sd <- sd(x[1:i])
        msg <- sprintf("n: %d \t média: %0.2f \t desvio: %0.2f",
                       i, mean, sd)
        ## Densidade acumulada de uma v.a. exponencial
        curve((1-exp(-lambda*x)), 0, 1.1*max(x),
              xlab="x", ylab="F(x)",
              main="Transformação Integral de Probabilidade")
        mtext(msg, side=3, cex=0.8)
        ## Valores gerados de uma uniforme projetados para o eixo x, ou seja
        ## gerando os numeros aleatorios de uma exponencial
        rug(u[1:i], side=2)
        points(x[1:i], u[1:i], pch=19)
        arrows(0, u[1:i], x[1:i], u[1:i], length=0.05, lty=8)
        arrows(x[1:i], u[1:i], x[1:i], 0, length=0.05, lty=8)
        rug(x[1:i])

        ## ---- Gráfico 2
        plot(x[1:i], type="l",
             main="Traço da cadeia\nde números gerados",
             xlab="", ylab="")

        ## ---- Gráfico 3
        hist(x[1:i], xlab="", ylab="", prob=TRUE,
             main="Histograma\ndos valores gerados")
        curve(dexp(x, lambda), col="blue", add=TRUE)

        ## ---- Gráfico 4
        plot(ecdf(x[1:i]), xlab="", ylab="",
             main="Densidade Acumulada\nEmpírica")
        curve(pexp(x, lambda), col="blue", add=TRUE)
    }
}

##=============================================================================
## Criando a interface

time = 0.50
w <- gwindow("Tranformação Integral de Probabilidade")
gbutton("Executar animação", container = w, handler = anima)


##=============================================================================
## Melhorias: utilizar as funções tkrplot e tkrreplot para o
## gráfico ser exibido na mesma janela do botão. Incluir controladores de
## play/pause (gbutton) e velocidade da animação(gslider ou gbutton).
