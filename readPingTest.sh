TARGET_DATE=`date +%Y-%m-%d`
if [ -z "$1" ]
   then
      echo No date supplied, using $TARGET_DATE
   else
      TARGET_DATE=$1
fi
echo -n $TARGET_DATE
date +" %R"
for NODE in 419e 423a 1d5 3852 3de6 f67f ; do echo -n "Failed tests to $NODE: " ; ssh dietpi@192.168.5.63 cat PingTest_$TARGET_DATE | grep failed | grep  $NODE | wc -l ; done
echo Same date from local machine
for NODE in 419e 423a 1d5 3852 3de6 f67f ; do echo -n "Failed tests to $NODE: " ; cat PingTest_$TARGET_DATE | grep failed | grep  $NODE | wc -l ; done
# PingTest_2024-10-31
ssh dietpi@192.168.5.63 cat PingTest_$TARGET_DATE | grep 3de6
cat PingTest_$TARGET_DATE | grep 01d5
