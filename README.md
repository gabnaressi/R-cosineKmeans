# R-cosineKmeans
Small function for running K-means using cosine distance as the distance metric. Centroids are initialized with random data points.

## dependencies
R Package "lsa".

## instructions
Source the file kmeanscosine.R, then call the method kmeanscosine()

## parameters
- data: your data in matrix or data.frame form, with numeric columns only.
- k: the number of desired cluster centroids.
- scale: True by default. Will run the base method `scale()` if True.
- max.iter: number of maximum iterations. `Inf` by default.
