updatePoisson <- function(Y, A, s, mu, delta) {
  #s is the sequencing depth (e.g. 10.875)
  #mu is the baseline espression in inactivated state (e.g. 0.1)
  #delta is a vector size d (number of genes) in which each element is positive integer (e.g. delta=rep(3,length(Y))
  #delt=rep(delta,length(Y))
  S <- vector('numeric')
  for(i in 1:nrow(A)) {
   temp2 <- s*exp(mu)*(A[i,]==0)+s*exp(mu+delta)*(A[i,]==1)
   S[i] <- prod(exp(-temp2+Y*log(temp2)-lgamma(Y+1)))
  }
return(S)
}