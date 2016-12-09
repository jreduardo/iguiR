## Modelo de regressão dinâmico
## Ilustração do método do filtro de Kalman


## Definição do modelo normal com estrutura de passeio aleatório em \theta
##
## y_{t} = \theta_{t} + \nu_{t}
## \theta_{t} = \theta_{t-1} + \omega_{t}
##

## Simulação de dados-------------------------------
sim.pa <- function(n=100, V=0.2, W=0.3, phi=1){
  set.seed(1)
  w <- rnorm(n, 0, sqrt(W))
  v <- rnorm(n, 0, sqrt(V))
  theta <- w[1]
  for (i in 2:n)
    theta[i] <- phi*theta[i-1] + w[i]
  y <- theta + v
  return(list(y, theta))
}

y <- sim.pa()[[1]]
theta <- sim.pa()[[2]]


## Gráfico de dispersão das observações
require(lattice)
require(latticeExtra)
xyplot(y~1:100)
xyplot(y~1:100) +
  as.layer(xyplot(theta~1:100, type=c("l"), col=2))


## Estrutura para o modelo com intercepto dinâmico intercepto: filtragem manual...

## Valores iniciais

# Número de observações
n = 100
# Observações
y
# vetor de 1's
F <- rep(1,n)
# Valores iniciais
w0 = 1e5
m0 = 0
# Valores dos ruídos
V = 1 # Chute
W = 1 # Chute
#V = 0.216 # Chute ótimo
#W = 0.247 # Chute ótimo
## Coeficiente de estado
G = .5 # Chute
#G = 1 # Chute ótimo
## estados
theta.s <- rep(m0, n+1)
theta.f <- rep(m0, n+1)
theta.p <- rep(m0, n+1)
## vetor de erros
e <- rep(0,n)
## Inversa
inv <- rep(V,n)
##
W.s <- rep(W, n+1)
W.f <- rep(W, n+1)
W.p <- rep(W, n+1)


plot(1:100, y, xlab="Tempo")

for (i in 1:n+1) {
  ## Equações de  atualização do tempo (Previsão)
  theta.p[i] <- G*theta.f[i-1] # Avança o estado no tempo
  W.p[i] <- G*W.f[i-1]*t(G) + W # Avança a covariância no tempo
  ## Equações de atualização das medições (Correção)
  inv[i-1] <- F[i-1]*W.p[i]*F[i-1] + V
  K <- (W.p[i]*F[i-1])/inv[i-1] # calcula o ganho de Kalman
  e[i-1] <- y[i-1] - F[i-1]*theta.p[i]
  theta.f[i] <- theta.p[i] + K*e[i-1] # Atualiza a variavel de estado com yt
  W.f[i] <- W.p[i] - K*F[i-1]*W.p[i] # Atualiza a matriz de covariância
  Sys.sleep(0.1)
  plot(1:100, y, xlab="Tempo")
  points(1:(i-1),theta.f[1:(i-1)], col=2, pch=16)
}



require(animation)

saveHTML({
  for (i in 1:n+1) {
    ## Equações de  atualização do tempo (Previsão)
    theta.p[i] <- G*theta.f[i-1] # Avança o estado no tempo
    W.p[i] <- G*W.f[i-1]*t(G) + W # Avança a covariância no tempo
    ## Equações de atualização das medições (Correção)
    inv[i-1] <- F[i-1]*W.p[i]*F[i-1] + V
    K <- (W.p[i]*F[i-1])/inv[i-1] # calcula o ganho de Kalman
    e[i-1] <- y[i-1] - F[i-1]*theta.p[i]
    theta.f[i] <- theta.p[i] + K*e[i-1] # Atualiza a variavel de estado com yt
    W.f[i] <- W.p[i] - K*F[i-1]*W.p[i] # Atualiza a matriz de covariância
    plot(1:100, y, xlab="Tempo")
    points(1:(i-1),theta.f[1:(i-1)], col=2, pch=16)
  }
}, verbose=FALSE)
