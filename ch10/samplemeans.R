source("..\ch9\readCensus.r")

df <- readCensus()

s <- sample(df$april10census, size=8, replace=TRUE)
mean(s)

# appxrox mean
# getting a random sample of 8 states population, and calculating the mean
# replicating that process N times, then calculating mean of that
sampleMeans <- replicate(10000, 
                         mean(sample(df$april10census,size=5,replace=TRUE)), 
                         simplify=TRUE)
