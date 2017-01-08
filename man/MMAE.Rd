\name{MMAE}
\alias{MMAE}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Multiple Model Adaptive Estimation
}
\description{
This function implements the Multiple Model Adaptive Estimation (MMAE) algorithm, which implements a bank of Boolean Kalman Filters running in parallel on a dataset in order to estimate model parameters. 
}
\usage{
MMAE(data, net, p, threshold, Prior = NA, obsModel = NA)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{data}{
Data from which the MMAE algorithm should attempt to estimate parameters
}
\item{net}{
A vector of potential networks, defined in the BoolNet \code{loadNetwork} vernacular, from which the MMAE algorithm should choose the most probable network for the given data in \code{Y}
}
\item{p}{
A vector containing different possible intensities of Bernoulli process noise, from which the MMAE algorithm should choose the most likely
}
\item{threshold}{
A posterior probability threshold value (between 0 and 1) for which the MMAE should stop running
}
\item{Prior}{
A vector of the prior probabilities of the possible combinations of the various networks and process noise parameters input to the algorithm. The vector must be of size \code{length(net)*length(p)}. The entries into the vector will follow the pattern:
\cr
\cr
net1, p1\cr
net1, p2\cr
...\cr
netm, pn\cr
\cr
where m is the total number of potential networks and n is the total number of the possible \code{p} values.
The default prior ovse models is uniform.
}
\item{obsModel}{
Parameters for the chosen observation model.\cr
}
}
\value{
The MMAE algorithm will return which network and process noise value is most likely to have generated the given dataset supplied in \code{Y}. 
\cr
\cr
If the posterior probability for any of the combinations of networks and process noise parameters fails to surpass the value defined in the \code{threshold} variable, the algorithm will output that no decision could be made using the given data. 
}
\source{
Imani, M., & Braga-Neto, U. (2015, November). Optimal gene regulatory network inference using the boolean kalman filter and multiple model adaptive estimation. In 2015 49th Asilomar Conference on Signals, Systems and Computers (pp. 423-427). IEEE.
}

\examples{

#load potential networks
data(p53net_DNAdsb0)
data(p53net_DNAdsb1)

net1 <- p53net_DNAdsb0
net2 <- p53net_DNAdsb1

#define observation model
observation = list(type = 'NB', s = 10.875, mu = 0.01, delta = c(2, 2, 2, 2), phi = c(3, 3, 3, 3))

#simulate data using one of the networks and a given 'p'
data <- simulateNetwork(net1, n.data = 100, p = 0.02, obsModel = observation)
       
#run MMAE to determine model selection and parameter estimation
MMAE(data, net=c("net1","net2"), p=c(0.02,0.1,0.15), threshold=0.8, obsModel = observation)


}

