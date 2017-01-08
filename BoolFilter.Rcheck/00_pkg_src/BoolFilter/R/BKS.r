BKS <- function(Y, net, p, obsModel = NA) {
  n.genes <- length(net$genes)
   #Create A matrix based on size of network
A <- as.matrix(expand.grid(rep(list(0:1), n.genes)))
Y_k <- t(Y)
lastT <- nrow(Y_k)
#declare all the matrices used in the algorithm
temp <- vector('numeric')
MSE <- vector('numeric')
PDV <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
PV <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
PDVS <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
DDV <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
DV <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
Beta <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
Xhat <- matrix(0, nrow=n.genes, ncol = nrow(Y_k))
XhatS <- matrix(0, nrow=n.genes, ncol = nrow(Y_k))

type <- toupper(obsModel[[1]])
s <- vector('numeric')

M <- generateM(A, p, net)

#run recursive BKS algorithm

temp <- vector('numeric')
PDV[,1] <- rep(1/2^n.genes,2^n.genes)
PV[,1] <- M%*%PDV[,1]
lastT <- nrow(Y_k)

for (k in 2:lastT) {
if(type == "BERNOULLI") {
  if(length(obsModel[[2]]) != 1 ) {stop('Bernoulli noise selected, however other observation model noise parameters are defined. See vignette for more information')}
  T <- diag(update(Y_k[k,], obsModel[[2]], A))
}

if (type == "GAUSSIAN") {
  if(length(obsModel[[2]]) != 4) {stop('Gaussian noise selected, however incorrect observation model noise parameters are defined. See vignette for more information')}
  T <- diag(updateGaussian(Y_k[k,], A, obsModel[[2]][1], obsModel[[2]][2], obsModel[[2]][3], obsModel[[2]][4]))
}
if (type == "POISSON") {
  if(!is.list(obsModel) | length(obsModel[[4]]) != n.genes) {stop('Poisson observation model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
  T <- diag(updatePoisson(Y_k[k,], A, obsModel[[2]], obsModel[[3]], obsModel[[4]]))
}

if (type == "NB") {
  if(!is.list(obsModel)| length(obsModel[[4]]) != n.genes | length(obsModel[[5]]) != n.genes) {stop('Negative Binomial model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
  T <- diag(updateNegativeBinom(Y_k[k,], A, obsModel[[2]], obsModel[[3]], obsModel[[4]], obsModel[[5]]))
}
if(!(type == "BERNOULLI" | type == "GAUSSIAN" | type == "POISSON" | type == "NB")) {stop('Invalid observation model specified')}
Beta[,k] <- T%*%PV[,k-1]
PDV[,k] <- Beta[,k]/sum(Beta[,k])
PV[,k] <- M%*%PDV[,k]
}


DV[,(lastT-1)] <- T%*%rep(1/2^n.genes, 2^n.genes)

for (k in (lastT-1):2) {
DDV[,k] <- t(M)%*%DV[,k]

  if(type == "BERNOULLI") {
    if(length(obsModel[[2]]) !=1 ) {stop('Bernoulli noise selected, however other observation model noise parameters are defined. See vignette for more information')}
    T <- diag(update(Y_k[k,], obsModel[[2]], A))
  }
  
  if (type == "GAUSSIAN") {
    if(length(obsModel[[2]]) != 4) {stop('Gaussian noise selected, however incorrect observation model noise parameters are defined. See vignette for more information')}
    T <- diag(updateGaussian(Y_k[k,], A, obsModel[[2]][1], obsModel[[2]][2], obsModel[[2]][3], obsModel[[2]][4]))
  }
  if (type == "POISSON") {
    if(!is.list(obsModel) | length(obsModel[[4]]) != n.genes) {stop('Poisson observation model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
    T <- diag(updatePoisson(Y_k[k,], A, obsModel[[2]], obsModel[[3]], obsModel[[4]]))
  }
  
  if (type == "NB") {
    if(!is.list(obsModel)| length(obsModel[[4]]) != n.genes | length(obsModel[[5]]) != n.genes) {stop('Negative Binomial model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
    T <- diag(updateNegativeBinom(Y_k[k,], A, obsModel[[2]], obsModel[[3]], obsModel[[4]], obsModel[[5]]))
  }
  if(!(type == "BERNOULLI" | type == "GAUSSIAN" | type == "POISSON" | type == "NB")) {stop('Invalid observation model specified')}
DV[,(k-1)] <- T%*%DDV[,k]
}

for( S in 2:lastT){
PDVS[,S] <- (PV[,(S-1)]*DV[,(S-1)])/sum((PV[,(S-1)]*DV[,(S-1)]))
XhatS[,S] <- round(t(A)%*%PDVS[,S])
MSE[S] <- sum(abs(t(A)%*%PDVS[,S] - round(t(A)%*%PDVS[,S])))
}

list(Xhat = round(XhatS), MSE = MSE)
}
