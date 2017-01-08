update <- function(Y, qn, Xk) {
temp <- vector('numeric')
s <- abs(Xk - matrix(rep(Y, nrow(Xk)), ncol = length(Y), byrow=TRUE))
tmp <- (s*qn + (1-s)*(1-qn))
temp <- apply(tmp, 1, prod)
return (temp)
}

