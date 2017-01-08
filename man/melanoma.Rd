\name{melanoma}
\alias{melanoma}
\docType{data}
\title{
Melanoma Regulatory Network
}
\description{
Melanoma Boolean regulatory network as described by E.R. Dougherty et al.
}
\usage{data("melanoma")}

\details{
The data consists of activities of 7 genes in melanoma regulatory network. The 7 genes are as follows: WNT5A, pirin, S100P, RET1, MART1, HADHB and STC2. 
}
\source{
E. R. Dougherty, R. Pal, X. Qian, M. L. Bittner, and A. Datta, "Stationary and structural control in gene regulatory networks: basic concepts," International Journal of Systems Science, vol. 41, no. 1, pp. 5-16, 2010.
}

\examples{
data(melanoma)

data <- simulateNetwork(melanoma, n.data = 100, p = .02,
                      obsModel = list(type = 'Bernoulli', 
                                      q = 0.05))
}
