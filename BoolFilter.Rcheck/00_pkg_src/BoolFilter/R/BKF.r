BKF <- function(Y, net, p, obsModel = NA) {
n.genes <- length(net$genes)
Y_k <- t(Y)
#Create A matrix based on size of network
A <- as.matrix(expand.grid(rep(list(0:1), n.genes)))
#declare all the matrices used in the algorithm
temp <- vector('numeric')
MSE <- vector('numeric')
PDV <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
Beta <- matrix(0, nrow=2^n.genes, ncol = nrow(Y_k))
Xhat <- matrix(0, nrow=n.genes, ncol = nrow(Y_k))
Xhat2 <- matrix(0, nrow=n.genes, ncol = nrow(Y_k))
M <- generateM(A, p, net)
#run recursive BKF algorithm
temp <- vector('numeric')
PDV[,1] <- rep(1/2^n.genes,2^n.genes)

type <- toupper(obsModel[[1]])
for (k in 2:nrow(Y_k)) {
  if (!any(is.na(Y_k[k,]))) {
    if (type == 'BERNOULLI') {
    if(length(obsModel[[2]]) !=1 ) {stop('Bernoulli noise selected, however other observation model noise parameters are defined. See vignette for more information')}
T <- diag(update(Y_k[k,], obsModel[[2]], A))
}

if (type == "GAUSSIAN") {
  if(length(obsModel[[2]]) != 4) {stop('Gaussian noise selected, however incorrect observation model noise parameters are defined. See vignette for more information')}
  T <- diag(updateGaussian(Y_k[k,], A, obsModel[[2]][1], obsModel[[2]][2], obsModel[[2]][3], obsModel[[2]][4]))
}

if (type == "POISSON") {
  if(!is.list(obsModel) | length(obsModel[[3]]) != n.genes) {stop('Poisson observation model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
  T <- diag(updatePoisson(Y_k[k,], A, obsModel[[2]], obsModel[[3]], obsModel[[4]]))
}

if (type == "NB") {
  if(!is.list(obsModel)| length(obsModel[[4]]) != n.genes | length(obsModel[[5]]) != n.genes) {stop('Negative Binomial model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
  T <- diag(updateNegativeBinom(Y_k[k,], A, obsModel[[2]], obsModel[[3]], obsModel[[4]], obsModel[[5]]))
}
}
if(!(type == "BERNOULLI" | type == "GAUSSIAN" | type == "POISSON" | type == "NB")) {stop('Invalid observation model specified')}
Beta[,k] <- T%*%M%*%PDV[,k-1]
PDV[,k] <- Beta[,k]/sum(Beta[,k])
Xhat[,k] <- t(A)%*%PDV[,k]
MSE[k] <- sum(abs(Xhat[,k] - round(Xhat[,k])))
}

list(Xhat = round(Xhat), MSE = MSE, Beta = colSums(Beta))
}
