# Require ipoptr
library(ipoptr)

# Some function
eval_f <- function(x) { 
    return( 100 * (x[2] - x[1] * x[1])^2 + (1 - x[1])^2 )
}

# Some other function
eval_grad_f <- function(x) { 
    return( 
        c( 
            -400 * x[1] * (x[2] - x[1] * x[1]) - 2 * (1 - x[1]), 
            200 * (x[2] - x[1] * x[1])
        )
    )
}

# Nitty gritty!
x0 <- c( -1.2, 1 ) 
res <- ipoptr( x0=x0, eval_f=eval_f, eval_grad_f=eval_grad_f )

# Done
