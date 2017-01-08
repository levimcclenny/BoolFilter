rowmatch <- function(A,B) { 
  # Rows in A that match the rows in B 
  f <- function(...) paste(..., sep=":") 
  if(!is.matrix(B)) B <- matrix(B, 1, length(B)) 
  a <- do.call("f", as.data.frame(A)) 
  b <- do.call("f", as.data.frame(B)) 
  match(b, a) 
} 