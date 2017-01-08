updateGaussian <- function(Y, A, mu0, sigma0, mu1, sigma1) {
S <- vector('numeric')
temp <- (A==0)*mu0 + (A==1)*mu1
s <- abs(temp - matrix(rep(Y, nrow(temp)), ncol = length(Y), byrow=TRUE))
for(i in 1:nrow(A)) {
  temp2 <- (A[i,]==1)*sigma1^2+(A[i,]==0)*sigma0^2
  S[i] <- prod((1/sqrt(2*pi*temp2))*exp(-s[i,]^2/(2*temp2)))
}
return(S)
}