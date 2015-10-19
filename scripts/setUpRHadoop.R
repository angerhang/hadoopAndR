# This is to set up the hadoop environments in R 
# You can omit the following part if you have run RHadoop before
Sys.setenv("HADOOP_CMD"="/usr/local/Cellar/hadoop/2.7.1/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/usr/local/Cellar/hadoop/2.7.1/libexec/share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar")
Sys.setenv(HADOOP_HOME="/usr/local/Cellar/hadoop/2.7.1") 
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home") 

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