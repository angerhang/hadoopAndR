# This is to set up the hadoop environments in R 
# You can omit the following part if you have run RHadoop before
Sys.setenv("HADOOP_CMD"="/Users/yuancalvin/hadoop-2.6.0/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/Users/yuancalvin/hadoop-2.6.0/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar")
Sys.setenv(HADOOP_HOME="/Users/yuancalvin/hadoop-2.6.0") 
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home")

# Sys.getenv("HADOOP_CMD")
# Sys.getenv("HADOOP_STREAMING")
Sys.getenv("JAVA_HOME")

# Install the packages needed for Rhadoop
install.packages(c("rJava", "Rcpp", "RJSONIO", "bitops", "digest", "functional", "stringr", "plyr", "reshape2", "caTools"))

# The path will be the place that you place download your packages at 
# Go to "https://github.com/RevolutionAnalytics/RHadoop/wiki/Downloads"
# to download rhbase, rhdfs and rmr2
install.packages("~/Desktop/rhbase_1.2.1.tar", repos = NULL, type="source")
install.packages("~/Desktop/rhdfs_1.0.8.tar", repos = NULL, type="source")
install.packages("~/Desktop/rmr2_3.3.1.tar", repos = NULL, type="source")

library(rhbase)
library(rhdfs)
library(rmr2)