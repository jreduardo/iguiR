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
## geoR
##
## I. Variograms
## II. Prediction maps
##
##=============================================================================

##
## rpanel
##
require( rpanel )

## Other packages
if( !require( geoR ) ){
    ## Geostatistical functions
    install.packages( "geoR", dep = T )
    require( geoR )
}
if( !require( R.utils ) ){
    ## capitalize() / decapitalize()
    install.packages( "R.utils", dep = T )
    require( R.utils )
}

## Plot variograms
vg.draw <- function( panel ) {

    ## Args
    phi <- as.numeric( panel$phi )
    kappa <- as.numeric( panel$kappa )
    cov.model <- panel$cov.model

    ## Data
    x <- grf( 1e2
           , cov.model = cov.model
           , cov.pars = c( 1, phi )
           , kappa = kappa )

    ## Empirical variogram
    vg <- variog( x )

    ## Theoretical variogram
    vf <- variofit( vg, cov.model = cov.model
                 , ini.cov.pars = c(1, phi)
                 , kappa = kappa )

    ## Plot
    plot( vg, main = bquote( .( capitalize( sub( "[.]", " ", cov.model ) ) ) ~ "model"), ylim = c(0,2) )
    legend( "topleft", legend = c( as.expression( bquote( phi ~ ": " ~ .( formatC( phi, digits = 2, format = "f" ) ) ) )
                         , bquote( kappa ~ ": " ~ .( formatC( kappa, digits = 2, format = "f" ) ) ) )
                         , bty = "n", title = "Parameters" )
    lines( vf, lty = 2 )

    ## Return
    panel
}

##
## Create a new panel with some initial data
##
panel <- rp.control( phi = 0.2, kappa = 0.5, cov.model = "exp" )

## cov.model (See cov.spatial{geoR} )
## gneiting.matern and gencauchy not allowed
## 'cause they need two values for kappa
models <- c( "matern", "exponential", "gaussian", "spherical"
          , "circular", "cubic", "wave", "power", "powered.exponential"
          , "cauchy", "gneiting", "pure.nugget" )
models.names <- capitalize( models )
models.names <- sub( "[.]", " ", models.names )
rp.radiogroup( panel, cov.model
            , vals = models
            , labels = models.names
            , action = vg.draw
            , title = "Covariance model" )

rp.radiogroup( panel, phi
            , formatC( seq(0, 1, l = 11), digits = 2, format = "f" )
            , action = vg.draw
            , title = as.expression( bquote(phi) ) )

rp.radiogroup( panel, kappa
            , formatC( seq(0, 2, l = 5), digits = 2, format = "f" )
            , action = vg.draw
            , title = as.expression( bquote(kappa) ) )
