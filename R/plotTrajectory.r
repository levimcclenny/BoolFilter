plotTrajectory <- function(dataset1, labels = NA,  dataset2 = NA, compare = FALSE, byrow = TRUE){
if(!is.numeric(dataset1)) {stop('Input is not numeric')}
if(!byrow) {
  dataset1 <- t(dataset1)
}
if(nrow(dataset1) > 4) {stop('Number of trajectories is greater than 4. Reduce the number of gene trajectories to be plotted to continue.')}
par(mfrow = c(nrow(dataset1),1), mar = c(2.5,2.5,2.5,2.5))
if(!compare) {
for (i in 1:nrow(dataset1)) {
plot(dataset1[i,], type = 's', col = 'black',lwd = 2, cex.axis = 1.5, yaxt = 'n', main = labels[i])
axis(2, c(0,max(dataset1[i,])), cex.axis = 1.5)
#lines(data$originalX[,1], type = 's', col = 'black')
box(pch = 30)
}
}

else if(compare) {
  if (!any(is.numeric(dataset2))) {stop('A second (numeric) dataset must be input to compare!')}
  for (i in 1:nrow(dataset1)) {
  plot(dataset1[i,], type = 's', col = 'black',lwd = 2, cex.axis = 1.5, yaxt = 'n', main = labels[i])
  lines(dataset2[i,], type = 's', col = 'red',lwd = 2, lty = 2, cex.axis = 1.5)
  axis(2, c(0, max(dataset1[i,])), cex.axis = 1.5)
  #lines(data$originalX[,1], type = 's', col = 'black')
  box(pch = 30) 
  }
}
}
