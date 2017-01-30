TruthTable <- function(A, net) {
  g=net$genes
  n.genes=length(g)
  int= net$interactions
  
  A <- as.matrix(expand.grid(rep(list(0:1), n.genes)))
  
  Ap <- -1*A-1
  
  for(j in 1:length(g)){
    pred=int[[g[j]]][["input"]]
    out=int[[g[j]]][["func"]]
    B <- as.matrix(expand.grid(rep(list(0:1), length(pred))))
    vint=rep(0,nrow(B))
    for(t in 1:length(pred)){
      vint=vint+((B[,ncol(B)-t+1]==1)*2^(t-1))
    }
    Bp=B
    if(ncol(B)>1){
      Bp=B[sort(vint,index.return = TRUE)$ix,]
    }
    Ap[,j]=out[rowmatch(Bp,matrix(A[,pred],ncol=length(pred)) )]
  }
 
 return (Ap) 
}