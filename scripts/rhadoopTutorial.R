small.ints = 1:1000
sapply(small.int, function(x) x^2)

mapreduce(
  input = small.ints, 
  map = function(k, v) cbind(v, v^2))