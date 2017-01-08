\name{plotTrajectory}
\alias{plotTrajectory}
\title{
Plot state variables of Boolean Regulatory Systems
}
\description{
Allows for visualization of Boolean state variables. If \code{compare = TRUE}, the trajectory in \bold{BLACK} is dataset1 and the trajectory in \bold{RED} is dataset2.
}
\usage{
plotTrajectory(dataset1, 
               labels = NA, 
               dataset2 = NA, 
               compare = FALSE, 
               byrow = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataset1}{
Trajectory to be viewed. Input is limited to 4 variables to allow for concise viewing. Shown in \bold{BLACK}.
}
  \item{labels}{
Vector of labels to apply to plots
}
  \item{dataset2}{
If \code{compare = TRUE}, another dataset to be overlayed on dataset1. This is, again, limited to 4 variables. Shown in \bold{DASHED RED} if \code{compare = TRUE}.
}
  \item{compare}{
Set \code{compare = TRUE} if an overlay is desired
}
  \item{byrow}{
Set \code{byrow = FALSE} if the input data is not in the format of a single state variable corresponding to a row of the dataset.}
}

\examples{
data(p53net_DNAdsb1)

data <- simulateNetwork(p53net_DNAdsb1, n.data = 100, p = 0.02,
                        obsModel = list(type = 'Bernoulli',
                                        q = 0.05))


plotTrajectory(data$X,              
              labels = p53net_DNAdsb1$genes)
                        
                        
#View both (original state trajectory and observation) datasets overlayed
plotTrajectory(data$X,              
              labels = p53net_DNAdsb1$genes,
              dataset2 = data$Y,
              compare = TRUE)

}