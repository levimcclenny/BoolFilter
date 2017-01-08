\name{simulateNetwork}
\alias{simulateNetwork}

\title{
Simulate Boolean Network
}
\description{
Simulates a Boolean network and generates noise of user-defined model preference and paramters.
}
\usage{
simulateNetwork(net, n.data, p, obsModel)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{net}{
A boolean Network object (specified in BoolNet vernacular) to be simulated
}
  \item{n.data}{
Length of time-series to simulate
}
  \item{p}{
Process noise to build into the simulation. Should be 0<p<0.5.
}
  \item{obsModel}{
Parameters for the chosen observation model.
}

}
\details{

The \code{simulateNetwork} function can simulate many observation models to create observational data. An overvoew of how to use the various types of observation models present in \code{BoolFilter} is given below:

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

\item{Poisson observation model requires a list of parameters. This list will have 3 entries in addition to the type definition, for a total of 4 entries:
\itemize{
\item{Sequencing depth \code{s}}
\item{Baseline espression in inactivated state, referred to as \code{mu}}
\item{The differential expression, referred to as \code{delta}, which must be input as a vector of the same length as the number of genes in the network.}
}

In this way, the user can define the exact observation parameter for each individual gene. For a 4-gene network, a potential \code{obsModel} parameter for a Poisson distribution could be defined as:\cr \cr
\code{obsModel = list(type = 'Poisson', s = 10.875, mu = 0.01, delta = c(2, 2, 2, 2))}}
\cr
\item{
Negative-Binomial observation models also require a list of parameters. This list will have 4 entries in addition to the type definition, for a total of 5 entries:
\itemize{
\item{Sequencing depth \code{s}}
\item{Baseline espression in inactivated state, referred to as \code{mu}}
\item{Differential expression, referred to as \code{delta},  which must be input as a vector of the same length as the number of genes in the network.}
\item{Inverse Dispersion, referred to as \code{phi}, which must also be input as a vector of the same length as the number of genes in the network.}
}
For a 4-gene network, a potential \code{obsModel} parameter for a Negative-Binomial observation model could be defined as:\cr \cr
\code{delta = c(2, 2, 2, 2)} \cr
\code{phi = c(3, 3, 3, 3)} \cr
\code{obsModel = list(type = 'NB', s = 10.875, mu = 0.01, delta, phi)}}
\cr
}
}
\value{
\item{X}{Original Boolean state trajectory, \bold{without} observation noise}
\item{Y}{Observation trajectory}
}

\examples{
data(p53net_DNAdsb1)

#generate data from poisson observation model
dataPoisson <- simulateNetwork(p53net_DNAdsb1, n.data = 100, p = 0.02, 
                          obsModel = list(type = 'Poisson',
                                          s = 10.875, 
                                          mu = 0.01, 
                                          delta = c(2,2,2,2)))

#generate data from Bernoulli observation model
dataBernoulli <- simulateNetwork(p53net_DNAdsb1, n.data = 100, p = 0.02, 
                          obsModel = list(type = 'Bernoulli',
                                          q = 0.05))
}