##=============================================================================
## Interface para exibição do gráfico de dispersão das variáveis dist e
## speed do conjunto data(cars), aplicando transformações nas variáveis
## e ajustando uma regressão linear simples. São abordados os seguintes
## widgets:
##    * Listbox
##    * Checkbox
##=============================================================================

##-----------------------------------------------------------------------------
## Definições da sessão.

require(manipulate)
##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
## Função reativa (argumentos conforme interface a ser criada)
transformation <- function(tx, ty, reg){
    ## Variáveis utilizadas na aplicação
    x <- cars$speed
    y <- cars$dist
    ## Tranformando as variveis
    x <- switch(tx,
                Identidade = x,
                Quadrado = x^2,
                RaizQuadrada = sqrt(x),
                Log10 = log10(x)
                )
    y <- switch(ty,
                Identidade = y,
                Quadrado = y^2,
                RaizQuadrada = sqrt(y),
                Log10 = log10(y)
                )
    ## Exibindo graficamente
    plot(y ~ x, pch=20, main = "Gráfico de Dispersão",
         xlab = paste(tx, "de X", sep=" "),
         ylab = paste(ty, "de Y", sep=" "))
    m0 <- lm(y ~ x)
    r <- summary(m0)$r.squared
    c <- round(cor(x, y), 3)
    msg <- sprintf("R²: %0.3f \nCor: %0.3f", r, c)
    if(reg){
        abline(coef(m0), col=4)
        mtext(text = msg, side=3, cex=0.9, col=4,
              adj=0.05, line=-2)
    }
}
##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
## Criando a interface
manipulate(
    transformation(tx, ty, reg),
    tx = picker("Identidade", "Quadrado", "RaizQuadrada", "Log10"),
    ty = picker("Identidade", "Quadrado", "RaizQuadrada", "Log10"),
    reg = checkbox(FALSE, "Ajuste de Regressão Linear"))
##-----------------------------------------------------------------------------
