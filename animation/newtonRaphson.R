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
## Animation
##
require( animation )

## Other
require( shape )

##
## Newton-Raphson main function
##
newtonRaphson <- function( function.quote, ini, nIterations, diffLimit,  time.step = 5){

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
    ## 3. Plot
    ##
    main.plot <- curve( fx(x), from = -5, to = 5,  n = 1e3 )
    plot( main.plot, type = "l"
       , xlim = c( floor( ini*(-1) ), floor( ini*2 ) ), ylim = c(-100,100)
       , main = f, xlab = "x", ylab = "f(x)" )
    abline( h = 0, lty = 3 )


    ## ----------------------------------------
    ## 3. Iterations
    ##

    ## NR (NewtonRaphson) algorithm
    ## x1 = x0 - fx/dfdx
    .nr.core <- function( x0 ){
        if( dfx(x0) == 0 ) stop( "Zero division indefinition." )
        x0 - fx( x0 )/dfx( x0 )
    }

    ## Set initial value
    x1 <- ini

    ## Run iterations
    ani.options( interval = time.step)
    stop.cause <- "Iterations"
    t0 <- proc.time()["elapsed"]
    steps <- rep( NA, nIterations )
    steps[1] <- x1

    for( i in 1:nIterations ){

        x0 <- x1
        x1 <- .nr.core( x0 )

        ## New plot for each step
        plot( main.plot, type = "l"
           , xlim = c( floor( steps[i]*2 )*(-1) , floor( steps[i]*2 ) ), ylim = c(-100,100)
           , main = f, xlab = "x", ylab = "f(x)" )
        abline( h = 0, lty = 3 )

        ## Former points
        points( x = steps, y = rep(0, length = length(steps) ), col = gray(0.5), cex = 0.5 )

        ## Arrow
        x0.arrow <- if( x1 < steps[i] ){ x1 }else{ steps[i] }
        x1.arrow <- if( x1 > steps[i] ){ x1 }else{ steps[i] }
        print( x0.arrow )
        print( x1.arrow )
        Arrows( x0 = x0.arrow, x1 = x1.arrow
             , y0 = 0, y1 = 0
             , col = gray( 0 )
             , lty = 1 ##, code = ifelse( (steps[i] > x1), 1, 2 )
             , arr.type = "triangle" ##, arr.adj = 0.5
             , arr.length = 0.1
             , arr.width = 0.2 )

        ## Animation control
        ani.pause()
        print( cbind( steps[i], x1 ) )

        ## Step controls
        if( abs( x0 - x1 ) <= diffLimit ){
            stop.cause <- "Error limit"
            break
        }

        ## Recod steps
        steps[ i+1 ] <- x1

    }

    ## Last estimation
    plot( main.plot, type = "l"
       , xlim = c( floor( steps[i]*2 )*(-1) , floor( steps[i]*2 ) ), ylim = c(-100,100)
       , main = f, xlab = "x", ylab = "f(x)" )
    abline( h = 0, lty = 3 )
    points( x = steps, y = rep(0, length = length(steps) ), col = gray(0.5), cex = 0.5 )
    points( x = x1, y = 0, col = 3, pch = 16, cex = 1)

    ## Return
    list( res = x1, stop = stop.cause, steps = steps
       , time = proc.time()["elapsed"]-t0 )

}

f <- quote( x^5 + 4*x^4 -2*x^3 - 5*x - 100 )
saveGIF( {
    newtonRaphson( function.quote = f, ini = -15, nIte = 1e2, diffLimit = 1e-3, time.step = 0.2 )
},
        movie.name = "anipkg.newtonraphson.gif",
        ani.width = 500,
        ani.height = 300
)
