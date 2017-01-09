\name{BoolFilter-package}
\alias{BoolFilter-package}
\alias{BoolFilter}
\docType{package}
\title{
Optimal Estimation of Partially-Observed Boolean Dynamical Systems
}
\description{
Tools for optimal and approximate state estimation as well as network inference of Partially-Observed Boolean Dynamical Systems.
}
\details{
\tabular{ll}{
Package: \tab BoolFilter\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2017-01-08\cr
License: \tab Artistic-2.0\cr
}
Estimation of Partially-Observed Boolean Dynamical Systems (POBDS) is handled by various algorithms, revolving primarily around the Boolean Kalman Filter (\cite{\link{BKF}}). Other similar algorithms have been developed and documented in the BoolFilter package, including \cite{\link{BKS}} for batch datasets and the \cite{\link{SIR_BKF}} for large POBDS. 

These algorithms can be run on data with various types of noise including:

\itemize{
\item{Bernoulli}
\item{Gaussian}
\item{Poisson}
\item{Negative-Binomial}
}

These types of noise models are included to handle different potential observation noise that could be encountered in real applications. 

These observation noise models can be simulated in the \cite{\link{simulateNetwork}} function, which can generate both state and observation trajectories of user defined length and observation model preference. 

Additionally, the \cite{\link{plotTrajectory}} function can be implemented to visualize the trajectories of state variables.

}
\author{
Levi McClenny, Mahdi Imani, Ulisses Braga-Neto

Maintainer: Levi McClenny <levimcclenny@tamu.edu>
}
\references{
Braga-Neto U. Optimal state estimation for Boolean dynamical systems. In 2011 Conference Record of the Forty Fifth Asilomar Conference on Signals, Systems and Computers (ASILOMAR) 2011 Nov 6 (pp. 1050-1054). IEEE.
\cr
\cr
Imani, M., & Braga-Neto, U. Maximum-likelihood adaptive filter for partially-observed boolean dynamical systems. IEEE transaction on Signal Processing, 65:359-371, 2017.

Further references are listed in the corresponding reference sections
}


\examples{

data(p53net_DNAdsb0)
 
#Simulate data from a Bernoulli observation model
data <- simulateNetwork(p53net_DNAdsb0, n.data = 100, p = 0.02,
                        obsModel = list(type = "Bernoulli",
                                          p = 0.02))
                            
#Derive an estimate of the network using a BKF approach
Results <- BKF(data$Y, p53net_DNAdsb0, .02,
                        obsModel = list(type = "Bernoulli",
                                          p = 0.02))
                        
#View network approximation vs. correct trajectory
plotTrajectory(Results$Xhat,
                labels = p53net_DNAdsb0$genes,
                dataset2 = data$X,
                compare = TRUE)

}
