\name{SIR_BKF}
\alias{SIR_BKF}

\title{
Particle Filter
}
\description{
Performs the SIR-BKF algorithm approach in order to approximate the optimal MMSE estimate of state variables of a Partially-Observed Boolean Dynamical System. 
}
\usage{
SIR_BKF(Y, N, alpha, net, p, obsModel)
}
\arguments{

  \item{Y}{
Time series of noisy observations of the boolean regulatory network. \cr
Each row and column correspond to a specific Boolean variable and time point respectively.
}
  \item{N}{
Number of particles used in approximation
}
  \item{alpha}{
Parameter denoting the cutoff threshold for resampling
}
  \item{net}{
A Boolean Network object (specified in BoolNet vernacular) that the time series of observations presented in \code{Y} is based on
}
  \item{p}{
Intensity of Bernoulli process noise
}
\item{obsModel}{
Parameters for the chosen observation model.\cr
}
}
\details{
Exact optimal state estimation for partially-observed Boolean dynamical systems may become impractical computationally if system dimensionality is large. This opens the floor for an approximation algorithm to handle cases of high-dimensional systems. The SIR-BKF Particle Filtering algorithm contained in BoolFilter handles situations in which the Boolean Kalman Filter proves too computationally inefficient. 

The Particle Filtering approximation, like the Boolean Kalman Filter, can handle various observation models, including Bernoulli, Gaussian, Poisson, and Negative-Binomial, based on the input to the \code{obsModel} paramter. 

The obsModel parameter is defined the same as the \code{Boolean Kalman Filter} and \code{simulateNetwork} functions, reference the documentation for \cite{\link{BKF}} or \cite{\link{simulateNetwork}} for details.
}
\source{
Braga-Neto U. Particle filtering approach to state estimation in Boolean dynamical systems. In Global Conference on Signal and Information Processing (GlobalSIP), 2013 IEEE 2013 Dec 3 (pp. 81-84). IEEE.

}
\examples{
\donttest{
data(cellcycle)

obsModel = list(type = 'Gaussian', 
               model = c(mu0 = 1, sigma0 = 2, mu1 = 5, sigma1 = 2))

#generate data from Negative Binomial observation model for the
#10-gene Mammalian Cell Cycle Network
data <- simulateNetwork(cellcycle, n.data = 100, p = 0.02, obsModel)

#perform SIR-BKF algorithm
Results <- SIR_BKF(data$Y, N = 1000, alpha = 0.95, cellcycle, p = 0.02, obsModel)
                                          
}                                        

}

