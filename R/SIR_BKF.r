##############
#Algorithm for PF
##############
SIR_BKF <- function(Y, N, alpha, net, p, obsModel = NA) {
ngenes <- length(net$genes)
Yk <- t(Y)
A <- as.matrix(expand.grid(rep(list(0:1), ngenes)))
a <- rmultinom(1,N, (1/N)*rep(1,2^ngenes))
b <- which(a>0)
Sx <- rep(b, a[b])
Xo <- A[Sx,]
PDV <- matrix(0, nrow=2^ngenes, ncol = nrow(Yk))
MSE_PF <- vector('numeric')
Xhat <- matrix(0, nrow=ngenes, ncol = nrow(Yk))
NT <- alpha*N
X_k <- Xo
W <- rep(1/N, N)

type <- toupper(obsModel[[1]])
for (k in 2:nrow(Yk)) {
Xk <- abs(step.forward(X_k, p, net)) 
if (!any(is.na(Yk[k,]))) {
  if(type == "BERNOULLI") {
    if(length(obsModel[[2]]) !=1 ) {stop('Bernoulli noise selected, however other observation model noise parameters are defined. See vignette for more information')}
    Qh <- update(Yk[k,], obsModel[[2]], Xk)
  }
  
  if (type == "GAUSSIAN") {
    if(length(obsModel[[2]]) != 4) {stop('Gaussian noise selected, however incorrect observation model noise parameters are defined. See vignette for more information')}
    Qh <- updateGaussian(Yk[k,], Xk, obsModel[[2]][1], obsModel[[2]][2], obsModel[[2]][3], obsModel[[2]][4])
  }
  if (type == "POISSON") {
    if(!is.list(obsModel) | length(obsModel[[4]]) != ngenes) {stop('Poisson observation model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
    Qh <- updatePoisson(Yk[k,], Xk, obsModel[[2]], obsModel[[3]], obsModel[[4]])
  }
  
  if (type == "NB") {
    if(!is.list(obsModel)| length(obsModel[[4]]) != ngenes | length(obsModel[[5]]) != ngenes) {stop('Negative Binomial model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
    Qh <- updateNegativeBinom(Yk[k,], Xk, obsModel[[2]], obsModel[[3]], obsModel[[4]], obsModel[[5]])
  }
  if(!(type == "BERNOULLI" | type == "GAUSSIAN" | type == "POISSON" | type == "NB")) {stop('Invalid observation model specified')}
}

Qn <- (Qh*W)/(sum(Qh)*W)
N_eff <- 1/sum(Qn^2)

S <- rowmatch(A, Xk)
for (i in 1:N) {
  PDV[S[i], k] <- PDV[S[i], k] + Qn[i]
}
MSE_PF[k] <- sum(abs(t(A)%*%PDV[,k] - round(t(A)%*%PDV[,k])))


#Resample step
if( N_eff < NT) {
a <- rmultinom(1,N, Qn)
b <- which(a>0)
Sx <- rep(b, a[b])
Xk1 <- Xk[Sx,]
Qn <- rep(1/N, N)
Xk <- abs(Xk1)
}

W <- Qn


Xhat[,k] <- round(t(A)%*%PDV[,k])

X_k <- Xk
}

list(MSE = MSE_PF, Xhat = round(Xhat))
}
