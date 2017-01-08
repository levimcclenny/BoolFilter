simulateNetwork <- function(net, n.data, p, obsModel = NA) {
  n.genes <- length(net$genes)
X <- matrix(0, nrow = n.data, ncol = n.genes)
Xn <- matrix(0, nrow = n.data, ncol = n.genes)
Y <- matrix(0, nrow = n.data, ncol = n.genes)

X[1,] <- round(rep(0, n.genes))
Xn[1,] <- xor(X[1,], Rlab::rbern(n.genes, p))
for (i in 2:n.data) {
X[i,] <- BoolNet::stateTransition(net, Xn[i-1,])
Xn[i,] <- abs(xor(X[i,], Rlab::rbern(n.genes, p)))
}
if(!is.list(obsModel)) {stop('Invalid observation model specified')}
type <- toupper(obsModel[[1]])
if (type == "BERNOULLI") { #bernoulli observation noise
  if(length(obsModel[[2]]) !=1 ) {stop('Bernoulli noise selected, however other observation model noise parameters are defined. See vignette for more information')}
Y <- abs(xor(Xn, matrix(Rlab::rbern(n.data*n.genes, obsModel[[2]]), ncol = n.genes)))
}

if (type == "GAUSSIAN") { #gaussian observation model
  if(length(obsModel[[2]]) != 4) {stop('Gaussian noise selected, however incorrect observation model noise parameters are defined. See vignette for more information')}
  mu0 <- obsModel[[2]][1]
  sigma0 <- obsModel[[2]][2]
  mu1 <- obsModel[[2]][3]
  sigma1 <- obsModel[[2]][4]
Y <- (Xn>0)*rnorm(n.genes*n.data, mu1, sigma1) + (Xn == 0)*rnorm(n.genes*n.data, mu0, sigma0)
}

if (type == "POISSON") { #Poisson observation model
  if(length(obsModel) != 4 | !is.list(obsModel) | length(obsModel[[4]]) != n.genes) {stop('Poisson observation model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
    temp <- c()
    s <- obsModel[[2]]
    mu <- c(rep(obsModel[[3]], n.genes))
    delta <- obsModel[[4]]
   for(k in 1:n.data){
    temp <- rbind(temp,(Xn[k,]>0)*rpois(n.genes, s*exp(mu+delta)) + (Xn[k,] == 0)*rpois(n.genes, s*exp(mu)))
   }
  Y <- temp
}

if (type == "NB") { #Negative Binomial observation model
  if(length(obsModel) != 5 | !is.list(obsModel)| length(obsModel[[4]]) != n.genes | length(obsModel[[5]]) != n.genes) {stop('Negative Binomial model selected, however incorrect observation model noise parameters are defined. Ensure obsModel is of type LIST. See vignette for more information')}
  temp <- c()
  s <- obsModel[[2]]
  mu <- c(rep(obsModel[[3]], n.genes))
  delta <- obsModel[[4]]
  phi <- obsModel[[5]]
   for(k in 1:n.data){
    lam <- s*exp(mu+delta)*(Xn[k,]==1)+s*exp(mu)*(Xn[k,]==0)
    temp <- rbind(temp,rnbinom(n.genes, size=phi, prob=phi/(phi+lam)))
   }
  Y <- temp
}

if(!(type == "BERNOULLI" | type == "GAUSSIAN" | type == "POISSON" | type == "NB")) {stop('Invalid observation model specified')}

list(X = t(Xn), Y=t(Y))

}
