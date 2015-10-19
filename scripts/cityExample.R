# Always need to set the enviroment before running rHadoop
Sys.setenv("HADOOP_CMD"="/usr/local/Cellar/hadoop/2.7.1/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/usr/local/Cellar/hadoop/2.7.1/libexec/share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar")
Sys.setenv(HADOOP_HOME="/usr/local/Cellar/hadoop/2.7.1") 
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home") 

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
hdfs.root <- '/user/yuancalvin/city'
hdfs.data <- file.path(hdfs.root, 'data')
hdfs.out <- file.path(hdfs.root, 'out')
system.time(out <- wordcount(hdfs.data, hdfs.out))