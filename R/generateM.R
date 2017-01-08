generateM <- function(A, p, net) {
  n.genes <- length(net$genes)
M <- matrix(0, nrow = 2^n.genes, ncol = 2^n.genes)
for ( i in 1:nrow(A)) {
s <- vector('numeric')
s <- abs(A - matrix(rep(BoolNet::stateTransition(net,A[i,]), nrow(A)), ncol = n.genes, byrow = TRUE))
tmp <- (s*p + (1-s)*(1-p))
M[,i] <- apply(tmp, 1, prod)
}
return(M)
}