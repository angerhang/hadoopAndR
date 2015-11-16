# We will compare the speed of r with Rhadoop on different sizes of data sets
# Kmeans using R on data set Iris
Iris = iris
Iris.features <- Iris
table(Iris$Species)
# setosa versicolor  virginica 
# 50         50         50 
# We know there are 3 different species in the data set
# So we make the clusters as 3.
Iris.features$Species <- NULL

result <- system.time(kmeans(Iris.features, 3))
# result
# user  system elapsed 
# 0.001   0.000   0.000 
# K-means clustering with 3 clusters of sizes 50, 38, 62
# 
# Cluster means:
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     5.006000    3.428000     1.462000    0.246000
# 2     6.850000    3.073684     5.742105    2.071053
# 3     5.901613    2.748387     4.393548    1.433871

# Kmeans
# Always need to set the enviroment before running rHadoop
Sys.setenv("HADOOP_CMD"="/Users/yuancalvin/hadoop-2.6.0/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/Users/yuancalvin/hadoop-2.6.0/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar")
Sys.setenv(HADOOP_HOME="/Users/yuancalvin/hadoop-2.6.0") 
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home")

# library(rhbase)
# library(rhdfs)
library(rmr2)

# This is an implemntation for Kmeans from rmr2 package
# @knitr kmeans-signature
kmeans.mr = 
  function(
    P, 
    num.clusters, 
    num.iter, 
    combine, 
    in.memory.combine) {
    ## @knitr kmeans-dist.fun
    dist.fun = 
      function(C, P) {
        apply(
          C,
          1, 
          function(x) 
            colSums((t(P) - x)^2))}
    ## @knitr kmeans.map
    kmeans.map = 
      function(., P) {
        nearest = {
          if(is.null(C)) 
            sample(
              1:num.clusters, 
              nrow(P), 
              replace = TRUE)
          else {
            D = dist.fun(C, P)
            nearest = max.col(-D)}}
        if(!(combine || in.memory.combine))
          keyval(nearest, P) 
        else 
          keyval(nearest, cbind(1, P))}
    ## @knitr kmeans.reduce
    kmeans.reduce = {
      if (!(combine || in.memory.combine) ) 
        function(., P) 
          t(as.matrix(apply(P, 2, mean)))
      else 
        function(k, P) 
          keyval(
            k, 
            t(as.matrix(apply(P, 2, sum))))}
    ## @knitr kmeans-main-1  
    C = NULL
    for(i in 1:num.iter ) {
      C = 
        values(
          from.dfs(
            mapreduce(
              P, 
              map = kmeans.map,
              reduce = kmeans.reduce)))
      if(combine || in.memory.combine)
        C = C[, -1]/C[, 1]
      ## @knitr end
      #      points(C, col = i + 1, pch = 19)
      ## @knitr kmeans-main-2
      if(nrow(C) < num.clusters) {
        C = 
          rbind(
            C,
            matrix(
              rnorm(
                (num.clusters - 
                   nrow(C)) * nrow(C)), 
              ncol = nrow(C)) %*% C) }}
    C}
## @knitr end

## sample runs
## 
out = list()
for(be in c("local", "hadoop")) {
  rmr.options(backend = be)
  out[[be]] = 
    ## @knitr kmeans-run    
    kmeans.mr(
      to.dfs(Iris.features),
      num.clusters = 3, 
      num.iter = 4,
      combine = FALSE,
      in.memory.combine = FALSE)
  ## @knitr end
}
# system.time(kmeans.mr(
#   to.dfs(Iris.features),
#   num.clusters = 3, 
#   num.iter = 4,
#   combine = FALSE,
#   in.memory.combine = FALSE))
#    user  system elapsed 
# 97.739  10.847  72.353 
# Apparently hadoop's time on a samll data size is lot more larger than
# that of built-in r kmeans. It also can be caused by optimization 
# in the the built-in kmeans.
# -------------------------------------------------------
# The results from Rhadoop pretty much conform with the results 
# using kmeans function in R, after 4 iterations. 
# > out
# $local
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# [1,]     5.007843    3.409804     1.492157   0.2627451
# [2,]     6.759184    3.040816     5.532653   1.9734694
# [3,]     5.798000    2.714000     4.330000   1.3960000
# 
# $hadoop
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# [1,]     5.512500    2.583333     3.883333    1.191667
# [2,]     5.006000    3.428000     1.462000    0.246000
# [3,]     6.498684    2.963158     5.228947    1.828947

# -------------------------------------------------------
# We want to enlarge out data set 
# by duplicating the original Iris data set
library(plyr)
data <- list()
# Number of duplicates 
N<- 10000
for (n in 1:N){
  data[[n]] = Iris.features
}
myNew <- ldply(data, rbind)
# Now the data set is approximately 55.5 MB

result <- system.time(kmeans(myNew, 3))
# > result
# user  system elapsed 
# 0.522   0.075   0.610 

result <- system.time(kmeans.mr(
  to.dfs(myNew),
  num.clusters = 3, 
  num.iter = 4,
  combine = FALSE,
  in.memory.combine = FALSE))
# user  system elapsed 
# 148.618  22.352 140.775 

# -------------------------------------------------------
# Now let's have a really large data set
data <- list()
# Number of duplicates 
N<- 200000
for (n in 1:N){
  data[[n]] = Iris.features
}
myNew <- ldply(data, rbind)
# Now the data set is approximately 1.1GB
result <- system.time(kmeans(myNew, 3))

# > result
# user  system elapsed 
# 9.983   9.999  22.277 

result <- system.time(kmeans.mr(
  to.dfs(myNew),
  num.clusters = 3, 
  num.iter = 4,
  combine = FALSE,
  in.memory.combine = FALSE))
# > result
# user   system  elapsed 
# 4410.197 1947.637 6925.120 
