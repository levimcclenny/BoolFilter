\name{BKF}
\alias{BKF}
\title{
Boolean Kalman Filter
}
\description{
Implements the Boolean Kalman Filter to derive the optimal MMSE estimate of state of a Partially Observed Boolean Dynamical System
}
\usage{
BKF(Y, net, p, obsModel)
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
A novel state-space signal model has been proposed for stochastic Boolean dynamical systems observed through noisy measurements, of which the Boolean Kalman Filter is the optimal MMSE estimator. State evolution is governed by Boolean functions (i.e. logic gates) and noise. The current system state, in which transitions between Boolean states can be perturbed by some process noise, creating an ergodic state transition matrix, is observed through an arbitrary noisy measurement. The optimal recursive MMSE estimator for this model is called the Boolean Kalman Filter (BKF), and an efficient algorithm has been proposed for its exact computation. This algorithm is presented here.

The Boolean Kalman Filtering algorithm can handle various observation models, including Bernoulli, Gaussian, Poisson, and Negative-Binomial, based on the input to the \code{obsModel} parameters. 

\itemize{
\item{Bernoulli observation model requires only one parameter, aside from declaring the type, e.g. \cr \cr
\code{obsModel = list(type = 'Bernoulli', q = 0.05)}}
\cr

\item {Gaussian observation model requires a vector of the observation parameters, which include the mean and standard deviation of Boolean variables in inactivated and activated states. This will be defined as a vector, e.g. \cr \cr
\code{mu0 = 1} \cr
\code{sigma0 = 2}\cr
\code{mu1 = 5}\cr
\code{sigma1 = 2}\cr
\code{obsModel = list(type = 'Gaussian', model = c(mu0, sigma0, mu1, sigma1))}}
\cr

\item{The Poisson observation model requires a list of parameters. This list will have 3 entries in addition to the type definition, for a total of 4 entries:
\itemize{
\item{Sequencing depth \code{s}}
\item{Baseline espression in inactivated state, referred to as \code{mu}}
\item{The differential expression, referred to as \code{delta}, which must be input as a vector of the same length as the number of Boolean variables in the network.}
}

In this way, the user can define the exact observation parameter for each individual gene. For a 4-gene network, a potential \code{obsModel} parameter for a Poisson distribution could be defined as:\cr \cr
\code{obsModel = list(type = 'Poisson', s = 10.875, mu = 0.01, delta = c(2, 2, 2, 2))}}
\cr
\item{
Negative-Binomial observation model also requires a list of parameters. This list will have 4 entries in addition to the type definition, for a total of 5 entries:
\itemize{
\item{Sequencing depth \code{s}}
\item{Baseline espression in inactivated state, referred to as \code{mu}}
\item{Differential expression, referred to as \code{delta},  which must be input as a vector of the same length as the number of Boolean variables in the network.}
\item{Inverse Dispersion, referred to as \code{phi}, which must also be input as a vector of the same length as the number of Boolean variables in the network.}
}
For a 4-gene network, a potential \code{obsModel} parameter for a Negative-Binomial observation model could be defined as:\cr \cr
\code{delta = c(2, 2, 2, 2)} \cr
\code{phi = c(3, 3, 3, 3)} \cr
\code{obsModel = list(type = 'NB', s = 10.875, mu = 0.01, delta, phi)}}
\cr
}
}
\value{
\item{Xhat}{Estimate the state of of the Partially-Observed Boolean Dynamical System based on the recursive BKF algorithm}
\item{MSE}{Mean Squared Error of the estimate returned by the BKF algorithm for each time instance}
\item{Beta}{Normalized PDV for each time instance}
}
\source{
Braga-Neto, U. (2011, November). Optimal state estimation for Boolean dynamical systems. In Signals, Systems and Computers (ASILOMAR), 2011 Conference Record of the Forty Fifth Asilomar Conference on (pp. 1050-1054). IEEE.
\cr
\cr
Imani, M., & Braga-Neto, U. Maximum-likelihood adaptive filter for partially-observed boolean dynamical systems. IEEE transaction on Signal Processing, 65:359-371, 2017.
}
\examples{
data(p53net_DNAdsb0)

obsModel = list(type = 'NB', 
                   s = 10.875, 
                  mu = 0.01, 
               delta = c(2, 2, 2, 2), 
                 phi = c(3, 3, 3, 3))

#Simulate a network with Negative-Binomial observation model
data <- simulateNetwork(p53net_DNAdsb0, n.data = 100, p = 0.02, obsModel)
          
#Derive the optimal estimate of the network using a BKF approach
Results <- BKF(data$Y, p53net_DNAdsb0, p = 0.02, obsModel)

}