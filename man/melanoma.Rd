\name{melanoma}
\alias{melanoma}
\docType{data}
\title{
Melanoma Regulatory Network
}
\description{
Melanoma Boolean regulatory network as described by sM.R. Yousefi, et al.
}
\usage{data(melanoma)}

\details{
The data consists of activities of 10 genes in melanoma regulatory network. The 10 genes are as follows: WNT5A, pirin, S100P, RET1, MMP3, PHOC, MART1, HADHB, synuclein, and STC2.
}
\source{
Yousefi, Mohammadmahdi R., and Edward R. Dougherty. "Intervention in gene regulatory networks with maximal phenotype alteration."" Bioinformatics 29.14 (2013): 1758-1767.
}

\examples{
data(melanoma)

data <- simulateNetwork(melanoma, n.data = 100, p = .02,
                      obsModel = list(type = 'Bernoulli', 
                                      q = 0.05))
}
