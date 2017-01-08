updateNegativeBinom <- function(Y, A, s, mu, delta, phi) {
  #s is the sequencing depth (an integer, e.g. 10.875)
  #mu is the baseline espression in inactivated state (an integer, e.g. 0.1)
  #delta is a vector size d (number of genes) in which each element is positive integer (e.g. delta=rep(3,length(Y))
  #phi is a vector size d (number of genes) in which each element is positive integer (e.g. delta=rep(2,length(Y))
  S <- vector('numeric')
  for(i in 1:nrow(A)) {
   temp2 <- s*exp(mu)*(A[i,]==0)+s*exp(mu+delta)*(A[i,]==1)
n1 <- Y+phi-1
x1 <- Y
gg <- n1-x1+1
  gg[gg==0]=1
  a=lgamma(n1+1)-lgamma(x1+1)-lgamma(gg)
  gg <- n1-x1+1
  a[gg==0] <- 0
    S[i] <- prod(exp(a+ Y*log(temp2 /(temp2 +phi))+phi*log(phi/(phi+temp2 ))))
  }
  return(S)
}