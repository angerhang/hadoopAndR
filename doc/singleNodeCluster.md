# Setting up a Single Node Cluster
The guide mostly follows the instructions on [hadoop apache.](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html)
You should set up hadoop properly according to the `README.md` before reading this file.
We will go though an example of how to run MapReduce locally.

## Execution
You should be in the hadoop directory

If you followed `README.me` for installation, then your hadoop should be
installed in ```/usr/local/Cellar/hadoop/2.7.1```.

### Starting the filesystem
Basically namenode manages the meta-data about the datanode, by formatting the namenode,
namenodes are cleaned up for new operation however the data in the datanodes are not lost.
```
$bin/hdfs namenode -format
```

This command starts a NameNode in the master machine and also start a SlaveNode
in each of the slave machine. In our case, single node cluster, the NameNode's machine is also the
SlaveNode's machine.
```
$sbin/start-dfs.sh
```

The web interface for the NameNode is ```http://localhost:50070/```

Next we are setting the directory within HDFS and move some system files to
our distributed system. The files to move could be any file you wnat, but the system
files can better demostrate the effects of the program we are running.
```
$ bin/hdfs dfs -mkdir /user
$ bin/hdfs dfs -mkdir /user/<username>
$bin/hdfs dfs -put libexec/etc/hadoop input
```

Now we are running a sample program
```
$ bin/hadoop jar libexec/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'
```
Basically, the program will count the number of files whose names start with `dfs` and has abitrary many [a-z] after the
first three letters.

Let's look at the output

```
 $ bin/hdfs dfs -get output output
 $ cat output/*
 ```

Stop the program when you are finished
```
$ sbin/stop-dfs.sh
```

