# Monitor deployment of nodes on the SfTI network (TI Board interface)
#
# Based on work by Steve Cosgrove 17 April 2024    Modified 20 June 2024
#
# This file should be downloaded to ~/IPtools/ and permissions changed so we can run it
#
# cd ~/IPtools
# wget https://raw.githubusercontent.com/SteveCossy/IPtools/master/deployment.sh
# chmod a+x deployment.sh
#
# This script should work from any connected node.
# It is recommended that another computer, such as a Raspberry Pi, be used to run this script
# The computer will need:
# * TI communications board
# * a /etc/hosts file that includes IPv6 addresses of nodes  That list can be downloaded from here:
#   https://gitlab.ecs.vuw.ac.nz/stevecos/sfti_network_notes/-/blob/1f9b3c4853ec59f4c4cd3da5645f0dd1ba16cf1f/hosts-field_nodes

# Check for command line list of nodes, or check all ten
# Parameter subsitution from: https://www.cyberciti.biz/tips/bash-shell-parameter-substitution-2.html
nodes="$*"
nodes=${nodes:-"1 2 3 4 5 6 7 8 9 10"}
nodes=" $nodes "

echo Checking these nodes: $nodes
echo Syntax\: $0 \<space sparated list of nodes\>
read -p "Hit enter to continue, or <CTRL> C to start again."

timestamp=`date +%F_%H-%M`
outputLocal=$HOME
outputFolder=/networking
outputFile=/deploy-$timestamp

outputPathLocal=$outputLocal$outputFolder$outputFile

# Create a new folder if necessary.  No error message if the folder doesn't work

mkdir -p $outputLocal$outputFolder

# Wait for the network to be available on this computer
ip address | grep 2020
RESULT=$?
TIME=0
INTERVAL=3
threshold=240

# Debug - comment out for real run
# RESULT=0

while [ $RESULT -eq 1 ]
do
   if [ $TIME -eq 0 ]
       then echo Local IP address not found, waiting
   fi
   ip address | grep 2020
   RESULT=$?
   echo Been waiting for $TIME seconds
   sleep $INTERVAL
   TIME=`expr $TIME + $INTERVAL`
   if [ $TIME -gt $threshold ]
       then RESULT=0
   fi
done

# Network is available. We can get on with it ...

# Remember when this deployment was started
timestamp=`date +%F,%H:%M`
Report=$timestamp
echo -n $Report >> $outputPathLocal

# waiting will be a boolean array as we check nodes
# We will start by waiting for all of them ...
declare -a waiting
for node in $nodes ;
   do
   waiting[ $node ]=true
   done
waitingStill=true

# Debug
# echo ${waiting[@]}

while $waitingStill
do
   for node in $nodes ;
      do
      if ${waiting[$node]} 
         then
         echo -n "Testing n$node, "
         ping6 -c 1 -w 3 n$node >/dev/null
         if [ $? -eq 0 ]
   #      if [ $node -eq 5 ] # debug
            then
            waiting[ $node ]=false
            echo
            echo n$node found\!
            echo
            timestamp=`date +%H:%M`
            Report="$Report, $timestamp-n$node" 
            echo -n ", $timestamp-n$node" >> $outputPathLocal
         fi
      fi
      done
   echo 
   waitingStill=false
   for node in $nodes ;
   do
      if waiting[ $node ]
         then waitingStill=true
      fi
   done
   if waitingStill
      then read -t 5 -p "Repeating the test in 5 seconds. <CTRL>-C to exit."
   fi
done

# echo $Report # This 'report' is written to file as it is built
echo "" >> $outputPathLocal


