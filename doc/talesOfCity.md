# A word count example using rHadoop

## Prerequisite
We want to count the occurances of each word of [A Tale of Two Cities](http://www.textfiles.com/etext/FICTION/) by Charles Dickens.
You can download the txt file and save it to the Desktop

## Change core-site.xml

```xml
property>
  <name>hadoop.tmp.dir</name>
  <value>/Users/<yourname>/hadoop-2.6.0/hadoop-${user.name}</value>
  <description>A base for other temporary directories.</description>
</property>
 
<property>
  <name>fs.default.name</name>
  <value>hdfs://localhost:9000</value>
  <description>The name of the default file system.  A URI whose
  scheme and authority determine the FileSystem implementation.  The
  uri's scheme determines the config property (fs.SCHEME.impl) naming
  the FileSystem implementation class.  The uri's authority is used to
  determine the host, port, etc. for a filesystem.</description>
</property>

<property>
  <name>mapred.job.tracker</name>
  <value>localhost:9001</value>
  <description>The host and port that the MapReduce job tracker runs
  at. If "local", then jobs are run in-process as a single map
  and reduce task.
  </description>
</property>

<property>
<name>mapred.tasktracker.tasks.maximum</name>
<value>8</value>
<description>The maximum number of tasks that will be run simultaneously by a
a task tracker
</description>
</property>

<property>
  <name>dfs.replication</name>
  <value>1</value>
  <description>Default block replication.
  The actual number of replications can be specified when the file is created.
  The default is used if replication is not specified in create time.
  </description>
  </property>
```
  
## Put the file into HDFS
The first thing we want to do is to start hadoop

```shell
$ cd <pathToHadoop>
$ ssh localhost
$ sbin/start-all.sh
```

Now we want to move the txt file from local machine into the HDFS to process.

```
$hadoop fs -mkdir -p /user/<yourname>
# Create the root directory for HDFS
$hadoop fs -mkdir /user/<yourname>/city
$hadoop fs -mkdir /user/<yourname>/city/data
$hadoop fs -copyFromLocal ~/Desktop/city.txt /user/<yourname>/city/data/city.txt
# Copy the txt file into HDFS
$hadoop fs -ls /user/<yourname>/city/data
# You should be able to see city.txt file
```

Then run the `cityExample.r` script to see how rHadoop works.
