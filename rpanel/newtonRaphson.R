##=============================================================================
##             60ª RBras e o 16º SEAGRO - Presidente Prudente - SP
##
##           B6MC2: Explorando interfaces gráficas interativas no R
##
##                                                        www.leg.ufpr.br/iguiR
##                                                   github.com/JrEduardo/iguiR
##
##                      Walmes Marques Zeviani - UFPR
##                      Vanessa Ferreira Sehaber - UFPR
##                      Eduardo Elias Ribeiro Junior - UFPR
##                      Henrique Aparecido Laureano - UFPR
##                      Karina Brotto Rebuli - UFPR
##
## Newton Raphson
##
## TI para valores iniciais: numeric input fields; input buttons; input increment box;
## AB para a prohxima etapa nweton-raphson: action buttons;
##
## @version
## 2015-05-25 karina.rebuli
##
##=============================================================================


##
## 3. Newton-Raphson main function
##
newtonRaphson <- function( function.quote, ini, nIterations, diffLimit ){

    ## ----------------------------------------
    ## 1. Function definition
    ##
    ## Expression
    f <- function.quote
    ## Function
    fx <- function(x){ eval( f ) }


    ## ----------------------------------------
    ## 2. Derivarive
    ##
    dfx <- function(x){ eval( D(f,"x") ) }


    ## ----------------------------------------
    ## 3. Iterations
    ##

    ## NR (NewtonRaphson) algorithm
    ## x1 = x0 - fx/dfdx
    .nr.core <- function( x0 ){ x0 - fx( x0 )/dfx( x0 ) }

    ## Set initial value
    x1 <- ini

    ## Run iterations
    stop.cause <- "Iterations"
    t0 <- proc.time()["elapsed"]

    for( i in 1:nIterations ){

        x0 <- x1
        x1 <- .nr.core( x0 )

        ## Step controls
        if( abs( x0 - x1 ) <= diffLimit ){
            stop.cause <- "Error limit"
            break
        }

    }

    ## Return
    list( res = x1, stop = stop.cause, time = proc.time()["elapsed"]-t0 )

}

f <- quote( 2*cos(x) - x^2 + 10 )

fx <- function(x){ eval( f ) }
curve( fx(x), from = -1e1, to = 1e1, n = 1e3 )
abline( h = 0, lty = 3 )

nr <- newtonRaphson( function.quote = f, ini = -100000.5, nIte = 1e1, diffLimit = 1e-1 )
nr
curve( fx(x), from = -1e1, to = 1e1, n = 1e3 )
abline( h = 0, lty = 3 )
abline( v = nr$res, col = 3 )
