MMAE <- function(data, net, p, threshold, Prior = NA, obsModel = NA) {
  if(is.na(Prior)){
  Prior <- rep(1/(length(p)*length(net)),length(p)*length(net))  
  }
  if(length(Prior)!=(length(p)*length(net))){
    cat("Error: The length of prior is not match with the length of possible models.")
    cat("\n")
    cat(" The prior probability should be given for all ")
    cat(length(p)*length(net))
    cat(" different models.")
    return()
  }
  diff_model <- as.matrix(expand.grid( c(list(p) , list(net)  ) ))

Bt <- c()
for(l in 1:nrow(diff_model)){
Bt <- rbind(Bt,BKF(data$Y, get(diff_model[l,2]), as.numeric(diff_model[l,1]),obsModel)$Beta)
}



Pr <- matrix(0,nrow=nrow(Bt),ncol=ncol(Bt))
Pr[,1] <- Prior
for(k in 2:ncol(Bt)){
nPr <- (Bt[,k]*Pr[,k-1])/sum(Bt[,k]*Pr[,k-1])
if(sum(is.na(nPr))!=0){
  nPr <- Pr[,k-1]
}
Pr[,k] <- nPr
}

#threshold=0.8
Pr_selec <- apply(Pr,2,max)
Model_selec <- apply(Pr,2,which.max)
Stop <- 0
# Stop the algorithm if posterior probability of any model exceeds the under defined threshold
if(max(Pr_selec)>threshold){
  Stop <- 1
  temp <- which(cumsum(Pr_selec>threshold)==1 )
    cat(" The infered model is")
    cat("\n")
    if(length(p)>1){
      cat(" p = ")
      cat(diff_model[Model_selec[temp[1]],1])
    }
    if(length(net)>1){
      cat("\n")
      cat(" Net = ")
      cat(diff_model[Model_selec[temp[1]],2])
    }
    cat("\n")
    cat(" The selected model is infered with ")  
    cat(temp[1])
    cat(" data.") 
    plot(Pr[Model_selec[temp[1]],1:temp[1]],type="l",lty=1,col=c("blue"),lwd=4.5,xlab="Time",ylab="Posterior Probability of The Correct Model",cex.axis = 1.3,pch=50, cex.lab = 1.3,ylim=c(0,1))
    abline(h=threshold)
    }

if (Stop == 0){
  cat(" Decision could not be made given input data.")
}

}
