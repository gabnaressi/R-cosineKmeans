kmeanscosine <- function(data, k, scale=T,max.iter=Inf){
  
  if(scale){
    names <- names(data)
    data <- scale(data)
    colnames(data) <- names
  }
  
  if(k < 1 | k > nrow(data))
    stop(paste0("Argument k must be in the following interval: [1,",nrow(data),"]"))
  
  library('lsa')
  
  centroids <- sample(1:nrow(data), k,replace=F)
  centroids <- (data[centroids,])
  
  if(is.vector(centroids))
    centroids <- as.matrix(t(centroids))
  
  colnames(centroids) <- names(data)
  
  
  clusters <- rep(0,nrow(data))
  
  iterations <- 0
  converged <- F
  while(!converged){
    
    clustersAntigo <- clusters
    dist <- 1 - cosine(x=t(as.matrix(rbind(data,centroids))))
    
    for(i in 1:length(clusters)){
      clusters[i] <- which.min(dist[i,(ncol(dist)-k+1):ncol(dist)])
    }
    
    for(i in 1:k){
      if(sum(clusters==i) > 1)
        centroids[i,] <- colMeans(data[clusters==i,])
      else
        centroids[i,] <- data[clusters==i,]
    }
    
    iterations<- iterations + 1
    
    if(all(clustersAntigo == clusters) | iterations == max.iter )
      converged<-T
    
  }
  return(list(clusters = clusters, centroids = centroids, iterations=iterations))
}