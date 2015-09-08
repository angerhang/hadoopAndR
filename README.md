# Hadoop-R System   

The goal of this repository is to demostrate how to set up a Hadoop and R system from scratch. (Mac Version) 

Things included:
* Configuration of Hadoop and R
* A few examples using Hadoop or R alone
* A few examples with data sizes ranging from small to large using Hadoop and R at the same time


## Prerequisites: 
#### Java

Check your java version with 
```
java -version
```
to make sure your java is at least 1.6.0. If not, go to System Preferences -> Java -> Update to get the latest version and reboot. (Warning: you might to need to uninstall the older Java after the update)

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
so that you don't need to enter password when Hadoop establishes connection but you can creat a SSH with a password if you wish.

## Hadoop Installation

Connect to localhost
```
ssh localhost
```
Download and install hadoop
```
brew install hadoop
# brew installs hadoop within /usr/local/Cellar/hadoop/2.7.1/
```

If Hadoop is installed successfully you should something similar to 
```  
$ hadoop version
Hadoop 2.7.1
Subversion https://git-wip-us.apache.org/repos/asf/hadoop.git -r 15ecc87ccf4a0228f35af08fc56de536e6ce657a
Compiled by jenkins on 2015-06-29T06:04Z
Compiled with protoc 2.5.0
From source with checksum fc0a1a23fc1868e4d5ee7fa2b28a58a
```

## Configuration 
This is the configuration for single node hadoop setup. For more details you can visit [Hadoop Wiki](http://wiki.apache.org/hadoop/GettingStartedWithHadoop).

```
cd /usr/local/Cellar/hadoop/2.7.1/libexec/etc/hadoop
```
to be in the setup directory. 

In `hadoop-env.sh` We need to set the JAVA environment variable by changing to JAVA implemantation to:
```
# The java implementation to use.
export JAVA_HOME=`/usr/libexec/java_home`
```




