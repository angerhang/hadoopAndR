# A word count example using rHadoop

# Prerequisite
We want to count the occurances of each word of [A Tale of Two Cities](http://www.textfiles.com/etext/FICTION/) by Charles Dickens.
You can download the txt file and save it to the Desktop

# Put the file into HDFS
The first thing we want to do is to start hadoop

```shell
$ cd <pathToHadoop>
$ ssh localhost
$ sbin/start-all.sh
```

Now we want to move the txt file from local machine into the HDFS to process.

```
$hadoop fs -mkdir -p /user/yourname
# Create the root directory for HDFS
$hadoop fs -mkdir /user/yourname/city
$hadoop fs -mkdir /user/yourname/city/data
$hadoop fs -copyFromLocal ~/Desktop/city.txt /user/yourname/city/data/city.txt
# Copy the txt file into HDFS
$hadoop fs -ls /user/yourname/city/data
# You should be able to see city.txt file
```

Then run the `cityExample.r` script to see how rHadoop works.
