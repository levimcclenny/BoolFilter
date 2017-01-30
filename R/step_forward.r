step.forward <- function(z, p, A, Ap, net) {
  ind=rowmatch(A,z)
  out=xor(Ap[ind,], matrix(Rlab::rbern(length(net$genes)*nrow(z), p), ncol=length(net$genes)))
  return(out)
}