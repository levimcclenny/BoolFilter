pkgname <- "BoolFilter"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "BoolFilter-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('BoolFilter')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("BKF")
### * BKF

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: BKF
### Title: Boolean Kalman Filter
### Aliases: BKF

### ** Examples

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




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("BKF", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("BKS")
### * BKS

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: BKS
### Title: Boolean Kalman Smoother
### Aliases: BKS

### ** Examples

data(p53net_DNAdsb0)

obsModel = list(type = 'Bernoulli', q = 0.02)

#Simulate a network with Bernoulli observation noise
data <- simulateNetwork(p53net_DNAdsb0, n.data = 100, p = 0.02, obsModel)
          
#Derive the optimal estimate of state of the network using the BKS algorithm
Results <- BKS(data$Y, p53net_DNAdsb0, p = 0.02, obsModel)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("BKS", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("BoolFilter-package")
### * BoolFilter-package

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: BoolFilter-package
### Title: Optimal Estimation of Partially-Observed Boolean Dynamical
###   Systems
### Aliases: BoolFilter-package BoolFilter

### ** Examples


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




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("BoolFilter-package", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MMAE")
### * MMAE

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MMAE
### Title: Multiple Model Adaptive Estimation
### Aliases: MMAE

### ** Examples


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





base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MMAE", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("SIR_BKF")
### * SIR_BKF

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: SIR_BKF
### Title: Particle Filter
### Aliases: SIR_BKF

### ** Examples

## No test: 
data(cellcycle)

obsModel = list(type = 'Gaussian', 
               model = c(mu0 = 1, sigma0 = 2, mu1 = 5, sigma1 = 2))

#generate data from Negative Binomial observation model for the
#10-gene Mammalian Cell Cycle Network
data <- simulateNetwork(cellcycle, n.data = 100, p = 0.02, obsModel)

#perform SIR-BKF algorithm
approx <- SIR_BKF(data$Y, N = 1000, alpha = 0.95, cellcycle, p = 0.02, obsModel)
                                          
## End(No test)                                        




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("SIR_BKF", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("melanoma")
### * melanoma

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: melanoma
### Title: Melanoma Regulatory Network
### Aliases: melanoma

### ** Examples

data(melanoma)

data <- simulateNetwork(melanoma, n.data = 100, p = .02,
                      obsModel = list(type = 'Bernoulli', 
                                      q = 0.05))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("melanoma", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("p53net_DNAdsb0")
### * p53net_DNAdsb0

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: p53net_DNAdsb0
### Title: p53 Negative-Feedback Gene Regulatory Boolean Network
### Aliases: p53net_DNAdsb0

### ** Examples

data(p53net_DNAdsb0)

data <- simulateNetwork(p53net_DNAdsb0, n.data = 100, p = .02,
                      obsModel = list(type = 'Bernoulli', 
                                      q = 0.05))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("p53net_DNAdsb0", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("p53net_DNAdsb1")
### * p53net_DNAdsb1

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: p53net_DNAdsb1
### Title: p53 Negative-Feedback Gene Regulatory Boolean Network
### Aliases: p53net_DNAdsb1

### ** Examples

data(p53net_DNAdsb1)

data <- simulateNetwork(p53net_DNAdsb1, n.data = 100, p = .02,
                      obsModel = list(type = 'Bernoulli', 
                                      q = 0.05))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("p53net_DNAdsb1", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotTrajectory")
### * plotTrajectory

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotTrajectory
### Title: Plot state variables of Boolean Regulatory Systems
### Aliases: plotTrajectory

### ** Examples

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




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotTrajectory", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("simulateNetwork")
### * simulateNetwork

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: simulateNetwork
### Title: Simulate Boolean Network
### Aliases: simulateNetwork

### ** Examples

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



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("simulateNetwork", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
