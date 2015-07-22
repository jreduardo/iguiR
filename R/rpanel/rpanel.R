##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## rpanel
require(rpanel)

##--------------------------------------------
## Exemplo apresentação

x <- precip
a <- extendrange(x, f=0.05)

hist.reactive <- function(input){
    bks <- seq(a[1], a[2], length.out=input$nclass+1)
    hist(x, breaks=bks)
    return(input)
}

panel <- rp.control(title="Histograma")
rp.slider(panel=panel, variable=nclass,
          title="Escolha o número de classes:",
          from=1, to=30, resolution=1, initval=10,
          action=hist.reactive)


##--------------------------------------------
## Exemplo adicional (gradio)

col <- c(Turquesa="#00CC99",
         Azul="#0066FF",
         Rosa="#FF3399",
         Laranja="#FF6600",
         Roxo="#660066",
         "Verde limão"="#99FF33")

hist.reactive <- function(input){
    bks <- seq(a[1], a[2], length.out=input$nclass+1)
    hist(x, breaks=bks,
         col = col[input$color])
    return(input)
}

panel <- rp.control(title="Histograma")
rp.slider(panel=panel, variable=nclass,
          title="Escolha o número de classes:",
          from=1, to=30, resolution=1, initval=10,
          action=hist.reactive)
rp.radiogroup(panel=panel, variable=color, vals=names(col),
              action=hist.reactive)

##--------------------------------------------
## Exemplos avançados

## Distribuições de probabilidade
source("https://raw.githubusercontent.com/JrEduardo/EduRPkg/master/rp.binom.R")
source("https://raw.githubusercontent.com/JrEduardo/EduRPkg/master/rp.norm.R")
rp.binom()
rp.norm()

## Exemplos da biblioteca
rp.ci()
rp.tables()

rp.cartoons()

## Exemplo para modelos não lineares
require(wzRfun)
rp.nls(model=rate~Int+(Top-Int)*conc/(Half+conc),
            data=Puromycin,
            start=list(
                Int=c(init=50, from=20, to=70),
                Top=c(init=150, from=100, to=200),
                Half=c(init=0.1, from=0, to=0.6)),
            subset="state",
            assignTo="Puro.fit",
            startCurve=list(col=3, lty=3, lwd=1),
            fittedCurve=list(col=4, lty=1, lwd=1.5),
            extraplot=function(Int, Top, Half){
                abline(h=c(Int, Top), v=Half, col=2, lty=2)
            },
            finalplot=function(Int, Top, Half){
                abline(h=c(Int, Top), v=Half, col=3, lty=1)
            },
            xlab="Concentration",
            ylab="Rate",
            xlim=c(0, 1.2),
            ylim=c(40, 220))
