# Setup Rhbase Rhdfs and RMR2 for rHadoop


## Prerequisite

### JAVA
Make sure your
```
$ java -version
$ javac -version
```
are the same.

### Thrift
Get Brew if you don't have it yet:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
If you do have Brew, try
```
brew update
```
and 
```
brew install thrift
```

### R packages

```
install.packages(c("rJava", "Rcpp", "RJSONIO", "bitops", "digest", "functional", "stringr", "plyr", "reshape2", "caTools"))
```

## Download Rhbase Rhdfs and RMR2

Go to [Rhadoop](https://github.com/RevolutionAnalytics/RHadoop/wiki/Downloads)
to download these three packages.

Then we need to set the variables before we can install the packages:

```
Sys.setenv(HADOOP_CMD="/usr/local/Cellar/hadoop/2.7.1/bin/hadoop")
Sys.setenv(HADOOP_HOME="/usr/local/Cellar/hadoop/2.7.1") 
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home") 
Sys.setenv(HADOOP_STREAMING="/usr/local/Cellar/hadoop/2.7.1/libexec/etc/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar ")
# Use the following command to see if the path is set properly 
# Sys.getenv("HADOOP_CMD")
```

Then we can install the packages by
```
install.packages("~/Desktop/rhbase_1.2.1.tar", repos = NULL, type="source")
install.packages("~/Desktop/rhdfs_1.0.8.tar", repos = NULL, type="source")
install.packages("~/Desktop/rmr2_3.3.1.tar", repos = NULL, type="source")
```
You should change the path to the files accordingly.
