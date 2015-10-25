# Always need to set the enviroment before running rHadoop
Sys.setenv("HADOOP_CMD"="/Users/yuancalvin/hadoop-2.6.0/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/Users/yuancalvin/hadoop-2.6.0/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar")
Sys.setenv(HADOOP_HOME="/Users/yuancalvin/hadoop-2.6.0") 
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home")

library(rhbase)
library(rhdfs)
library(rmr2)

# Map each word with a keypair like (the , 1), and (mine, 1)
map_word <- function(k, lines){
  wordsList <- strsplit(lines, '\\s')
  words <- unlist(wordsList)
  return(keyval(words, 1))
}

# For each word, we sum the total counts
reduce <- function(word, counts){
  keyval(word, sum(counts))
}

wordcount <- function(input, output=NULL){
  mapreduce(input=input, output = output, input.format = "text", map=map_word, reduce = reduce)
}

# Set up data source from hdfs
hdfs.root <- '/user/hang'
hdfs.data <- file.path(hdfs.root, 'data')
hdfs.out <- file.path(hdfs.root, 'out')
system.time(out <- wordcount(hdfs.data, hdfs.out))

result <- from.dfs(out)
results.df <- as.data.frame(result, stringsAsFactors = F)
colnames(results.df) <- c('word', 'count')