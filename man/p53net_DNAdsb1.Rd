\name{p53net_DNAdsb1}
\alias{p53net_DNAdsb1}
\docType{data}
\title{
p53 Negative-Feedback Gene Regulatory Boolean Network
}
\description{
The data consists of activities of 4 genes in the well-known p53-MDM2 negative-feedback gene regulatory network when the external input (called dna_dsb) to this system is ON or OFF. The p53 gene codes for the tumor suppressor protein p53 in humans, and its activation plays a critical role in cellular responses to various stress signals that might cause genome instability. The four genes are as follows: ATM, p53, Wip1, and MDM2. The input 'dna_dsb' indicates the presence of DNA double strand breaks. In this dataset, \bold{dna_dsb is 1}, indicating no external input.
}
\usage{data('p53net_DNAdsb1')}

\details{
The p53-MDM2 negative-feedback gene regulatory network described by E. Batchelor et al.
}
\source{
E. Batchelor, A. Loewer, and G. Lahav, "The ups and downs of p53: Understanding protein dynamics in single cells," Nature Rev. Cancer, vol. 9, no. 5, pp. 371-377, 2009.
}

\examples{
data(p53net_DNAdsb1)

data <- simulateNetwork(p53net_DNAdsb1, n.data = 100, p = .02,
                      obsModel = list(type = 'Bernoulli', 
                                      q = 0.05))
}

