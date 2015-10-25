# Hadoop-R System 

The goal of this repository is to demonstrate how to set up a Hadoop and R system from scratch. (Mac Version) 

Things included:
* Configuration of Hadoop and R
* A few example using Hadoop or R alone
* Run Hadoop and R at the same time

## Caveat
It is recommended to set up a new user account specially for Hadoop
usage due to security concerns. 

## Prerequisites: 
#### Java

Check your java version with 
```
java -version
```
to make sure your java is at least 1.6.0. If not, go to System
Preferences -> Java -> Update to get the latest version and
reboot. (Warning: you might to need to uninstall the older Java after
the update). Idealy, it is better not to use Apple's built in Java
since it isn't great for production. See more at [Apache Wiki](https://wiki.apache.org/hadoop/HadoopJavaVersions)

#### HomeBrew 
```
ruby -e "$(curl -fsSL    https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


#### Remote Login
Go to System Preferences -> Sharing to allow Remote Login 

#### SSH 

Generate the public private key
```
$ ssh-keygen -t rsa -P ""
```

Add it to the authorized keys
```
$ cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
```

Test the key with 
```
$ ssh localhost 
$ exit # to log out 
```
so that you don't need to enter password when Hadoop establishes connection but you can create a SSH with a password if you wish.

## Hadoop Installation

### Downlaod Hadoop
Go to
[hadoop download for ubuntu 14.04](http://hadoop.apache.org/releases.html)
to get the 2.6.0 binary file. Unzip it and place the folder into your
`$HOME` directory.

Connect to localhost
```
ssh localhost
```
Download and install Hadoop
Install brew if you don't have it yet. We will use it to install R
later on as well. 
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

If Hadoop is installed successfully you should something similar to 
```  
$ hadoop version
Hadoop 2.6.0
Subversion https://git-wip-us.apache.org/repos/asf/hadoop.git -r 15ecc87ccf4a0228f35af08fc56de536e6ce657a
Compiled by jenkins on 2015-06-29T06:04Z
Compiled with protoc 2.5.0
From source with checksum fc0a1a23fc1868e4d5ee7fa2b28a58a
```

## Configuration 
This is the configuration for single node Hadoop setup. For more details you can visit [Hadoop Wiki](http://wiki.apache.org/hadoop/GettingStartedWithHadoop).

```
cd ~/hadoop-2.6.0
```
to be in the setup directory. 

In `hadoop-env.sh` We need to set the JAVA environment variable by changing to JAVA implementation to:
```
# The java implementation to use.
export JAVA_HOME=/path/to/your/java
```

After setting the environment variable, you should be able to see
something similar:
```shell
$ bin/hadoop 
Usage: hadoop [--config confdir] [COMMAND | CLASSNAME]
  CLASSNAME            run the class named CLASSNAME
 or
  where COMMAND is one of:
  fs                   run a generic filesystem user client
  version              print the version
  jar <jar>            run a jar file
                       note: please  use "yarn jar" to launch
                             YARN applications, not this command.
  checknative [-a|-h]  check native hadoop and compression libraries availability
  distcp <srcurl> <desturl> copy file or directories recursively
  archive -archiveName NAME -p <parent path> <src>* <dest> create a hadoop archive
  classpath            prints the class path needed to get the
  credential           interact with credential providers
                       Hadoop jar and the required libraries
  daemonlog            get/set the log level for each daemon
  trace                view and modify Hadoop tracing settings

Most commands print help when invoked w/o parameters.
```

In `core-site.xml`, change the configuration into:
```xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

In `hdfs-site.xml`, change the configuration into:
```xml
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
	</property>
</configuration>
```

In `mapred-site.xml`, change the configuration into:
```xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
</configuration>
```

### PATH
It would be a good idea to also set the environment variables for
Hadoop:
```
export = HADOOP_HOME=/usr/local/Cellar/hadoop/2.6.0
export PATH=$PATH:$HADOOP_HOME/bin
```

## Execution 
After we installed Hadoop we need to format Hadoop Distributed
File System by
```
hadoop namenode -format
```

Start a daemon 
```
ssh localhost
cd /usr/local/Cellar/hadoop/2.6.0
./sbin/start-dfs.sh
```

You can look at the Namenode information at
```
http://localhost:50070/
```
from your browser. Or you can type `jps` to check the status of
the namenode.

Stop the daemon by
```
./sbin/stop-dfs.sh
```

## R Installation
### R Environment 
Brew will handle the R dependency for you automatically.
```
brew tap homebrew/science
brew install r
```

### R IDE
You might find it helpful to download
[R Studio](https://www.rstudio.com/products/rstudio/) for R development.
 
### Miscellaneous
If you are seeing a warning message like
```
15/09/20 15:05:05 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
```
it means you have a 64-bit operating system but your hadoop version is
32-bit. This shouldn't be a problem, but if you want to get rid of it,
you should then try to get the 64-bit hadoop installation and redo all
the steps above.
