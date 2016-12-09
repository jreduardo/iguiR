##--------------------------------------------------------------------------------------------------
## New-Raphson em uma dimensão

## Definindo a função e a sua derivada
f <- quote(sin(x)-x^2/16)        # expressão da função, queremos obter a raíz
fx0 <- function(x){ eval(f) }    # função
curve(fx0, -10, 10); abline(h=0) # gráfico da função

f1 <- D(f,"x")                   # expressão da derivada
fx1 <- function(x){ eval(f1) }   # função
par(new=TRUE); curve(fx1, -10, 10, col=2, axes=FALSE) # gráfico


## Definindo valores iniciais
i <- 1       # valor inicial para o passo
dif <- 10    # valor inical para a diferença entre duas avaliações
tol <- 10^-9 # diferência mínima entre duas avaliações (tolerância)
dif <- 100   # número máximo de passos
x <- -7      # valor inicial para a raiz

while(i<100 & dif>tol){
  x[i+1] <- x[i]-fx0(x[i])/fx1(x[i])
  dif <- abs(x[i+1]-x[i])
  i <- i+1
  print(x[i])
}



## Gráfico que ilustra a trajetória até a obtenção da raíz:
## Experimente outros valores iniciais. Veja que essa função tem 2 raízes, cada valor inicial
## vai levar à apenas uma delas!
curve(fx0, -10, 10)
abline(h=0)
for(j in 2:i){
  arrows(x[j-1], fx0(x[j-1]), x[j], fx0(x[j]), length=0.1, col=3)
  Sys.sleep(0.5)
}
abline(v=x[i], h=fx0(x[i]), col=2)



## Salvando em HTML
require(animation)

saveHTML({
  for(j in 2:i){
    curve(fx0, -10, 10, main=paste("passo ", j-1, ", (x = ",
                                   round(x[j],2), ")", sep=""))
    abline(h=0, lty=2)
    arrows(x[j-1], fx0(x[j-1]), x[j], fx0(x[j]), length=0.1, col=3, lwd=2)
    abline(v=x[j], h=fx0(x[j]), lty=3, col=2)
  }
  abline(v=x[i], h=fx0(x[i]), col=2, lwd=2)
  text(0, -3, label="CONVERGIU!", cex=2)
  ani.pause()
}, verbose=FALSE, img.name = "NR")

##--------------------------------------------------------------------------------------------------
