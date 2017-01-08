\name{BKS}
\alias{BKS}
\title{
Boolean Kalman Smoother
}
\description{
Genereates the optimal MMSE estimate of the state of a Partially-Observed Boolean Dynamical System by implementing a Boolean Kalman Smoother to batch data
}
\usage{
BKS(Y, net, p, obsModel)
}
\arguments{
\item{Y}{
Time series of noisy observations of the Boolean regulatory network. \cr
Each row and column correspond to a specific Boolean variable and time point respectively.
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
In the event that a sequence of measurements is available offline, the BKS can be used for computation of the optimal MMSE of smoothed trajectory.

The Boolean Kalman Smoother algorithm can handle various observation models, including Bernoulli, Gaussian, Poisson, and Negative-Binomial, based on the input to the \code{obsModel} parameter.

The obsModel parameter is defined the same as the \code{Boolean Kalman Filter} and \code{simulateNetwork} functions, reference the documentation for \cite{\link{BKF}} or \cite{\link{simulateNetwork}} for details.
}
\value{
\item{Xhat}{Estimate of the sate of the Partially-Observed Boolean Dynamical System based on the BKS algorithm}
\item{MSE}{Mean Squared Error of the estimate returned by the BKS algorithm for each time instance}
}
\source{
Imani, M., & Braga-Neto, U. (2015, December). Optimal state estimation for boolean dynamical systems using a boolean Kalman smoother. In 2015 IEEE Global Conference on Signal and Information Processing (GlobalSIP) (pp. 972-976). IEEE.
}
\examples{
data(p53net_DNAdsb0)

obsModel = list(type = 'Bernoulli', q = 0.02)

#Simulate a network with Bernoulli observation noise
data <- simulateNetwork(p53net_DNAdsb0, n.data = 100, p = 0.02, obsModel)
          
#Derive the optimal estimate of state of the network using the BKS algorithm
Results <- BKS(data$Y, p53net_DNAdsb0, p = 0.02, obsModel)

}

