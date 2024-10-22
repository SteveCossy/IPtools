# Installation for pingTrace utility

### Note that this utility will not work from the border router.

Follow install instructions from file: https://github.com/SteveCossy/IPtools/blob/master/pingTraceAll.sh
The output should look very close to this example:
``` :~$ cd IPtools/
:~/IPtools$ wget https://raw.githubusercontent.com/SteveCossy/IPtools/master/pingTraceAll.sh
--2024-10-21 17:24:31--  https://raw.githubusercontent.com/SteveCossy/IPtools/master/pingTraceAll.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.110.133, 185.199.108.133, 185.199.109.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2423 (2.4K) [text/plain]
Saving to: 'pingTraceAll.sh'
pingTraceAll.sh                                             100%[===========================================================
2024-10-21 17:24:31 (6.72 MB/s) - 'pingTraceAll.sh' saved [2423/2423]
:~/IPtools$ wget https://raw.githubusercontent.com/SteveCossy/IPtools/master/pingTrace.sh
--2024-10-21 17:24:56--  https://raw.githubusercontent.com/SteveCossy/IPtools/master/pingTrace.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.111.133, 185.199.109.133, 185.199.108.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.111.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1492 (1.5K) [text/plain]
Saving to: 'pingTrace.sh'
pingTrace.sh                                                100%[===========================================================
2024-10-21 17:24:57 (4.62 MB/s) - 'pingTrace.sh' saved [1492/1492]
:~/IPtools$ chmod a+x pingTraceAll.sh pingTrace.sh
:~/IPtools$
``` 
The instructions included setting up the file to run at regular intervals using **crontab**
<p>You can also test the file from the computer you have installed the files on. The USB device should be detected if it is present.</p>

``` :~/IPtools$ /home/jetson/IPtools/pingTraceAll.sh
USB device not found
USB = /media/jetson/KINGSTON/networking/pingTrace_odroid, found = false
Local = /home/jetson/networking/pingTrace_odroid
/home/jetson/networking/pingTrace_odroid
processing n1
processing n2
processing n3
processing n4
processing n5
processing n6
processing n7
processing n8
processing n9
processing n10
:~/IPtools$
``` 
You can now check the output file.
The examples here are based on this network: https://github.com/SteveCossy/IPtools/blob/master/pingTraceDiagram.png
<br>This example is from **n1**:
```
:~/IPtools$ cat /home/jetson/networking/pingTrace_n1
2024-10-21,17:32
n1 - 1 hop
n2 - 1,2,3 hops
n3 - 1,2 hops
n4 - 1,2,3 hops
n5 - 1,2,3,4 hops
n6 - 1 hop
n7 - 1,2,3 hops
n8 - 1,2 hops
n9 - 1,2,3 hops
n10 - 1,2,3,4 hops
:~/IPtools$
```
Another example, from node **n2** on the same diagram:
```
2024-10-21,16:27
n1 - 1,2,3 hops
n2 - 1 hop
n3 - 1,2 hops
n4 - 1,2,3 hops
n5 - 1,2 hops
n6 - 1,2,3 hops
n7 - 1 hop
n8 - 1,2 hops
n9 - 1,2,3 hops
n10 - 1,2 hops
```

