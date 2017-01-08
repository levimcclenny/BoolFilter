step.forward <- function(z, p, net) {
a <- t(apply(z, 1, function(x) {BoolNet::stateTransition(net,x)}))
a[a>0] = 1
a[a<0] = 0
b <- xor(a, matrix(Rlab::rbern(length(net$genes)*nrow(z), p), ncol=length(net$genes)))
return (b)
}