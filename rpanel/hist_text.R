require(rpanel)

x <- precip
ht <- hist(x)

hist.reactive <- function(input){
    plot(ht, col="#006666",
         ylab="Frequência absoluta",
         xlab="Precipitação",
         main=input$main,
         sub=input$sub)
    return(input)
}

panel <- rp.control(title="Histograma")
rp.textentry(panel=panel, variable=main,
             ## title="Texto para o título:",
             labels="Texto para o título:",
             initval="",
             action=hist.reactive)
rp.textentry(panel=panel, variable=sub,
             ## title="Texto para o subtítulo:",
             labels="Texto para o subtítulo:",
             initval="",
             action=hist.reactive)

## grep(x=ls("package:rpanel"), pattern="^rp\\.", value=TRUE)

