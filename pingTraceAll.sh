# Trace route to all nodes on the SfTI network (TI Board interface) using pingCount.sh which uses multiple pings
#
# Steve Cosgrove 21 October 2024
#
# Both files should be downloaded to ~/IPtools/ and permissions changed so we can run it
#
# cd ~/IPtools
# wget https://raw.githubusercontent.com/SteveCossy/IPtools/master/pingTraceAll.sh
# wget https://raw.githubusercontent.com/SteveCossy/IPtools/master/pingCount.sh
# chmod a+x pingTraceAll.sh pingCount.sh
#
# The following lines can be used to run this script every 30 minutes
# sudo crontab -e
# ... add this line to the end of the existing crontab file:
# */30 * * * * /home/jetson/IPtools/pingTraceAll.sh
#
# The results can be viewed with:
# cat <outputPath>
# where outputPath is a concatination of the output USB, Folder, and File below
# eg cat /media/jetson/KINGSTON/networking/pingTest
#

outputUSB=/media/jetson/KINGSTON
outputLocal=/home/jetson
outputFolder=/networking
outputFile=/pingTrace_$HOSTNAME

pingTraceFile=/home/jetson/IPtools/pingTrace.sh

timestamp=`date +%F,%H:%M`

outputPathUSB=$outputUSB$outputFolder$outputFile
outputPathLocal=$outputLocal$outputFolder$outputFile

if [ ! -d $outputUSB ]
then
    echo USB device not found
    USBfound=false
else
    USBfound=true
fi

echo USB = $outputPathUSB, found = $USBfound
echo Local = $outputPathLocal

# Create a new folder if necessary.  No error message if the folder doesn't work

mkdir -p $outputLocal$outputFolder

if $USBfound
   then sudo mkdir -p $outputUSB$outputFolder
fi

echo Connectivity check from `hostname` at `date` | sudo tee -a $outputPath

# Wait for the network to be available - not required for this script
# ip address | grep 2020
# RESULT=$?
#    TIME=0
#    INTERVAL=3
#    threshold=240

#    while [ $RESULT -eq 1 ]
#    do
#      if [ $TIME -eq 0 ]
#          then echo Local IP address not found, waiting | sudo tee -a $outputPath
#      fi
#      ip address | grep 2020
#      RESULT=$?
#      echo Been waiting for $TIME seconds
#      sleep $INTERVAL
#      TIME=`expr $TIME + $INTERVAL`
#      if [ $TIME -gt $threshold ]
#          then RESULT=0
#      fi
#    done

# echo $Report | tee -a $outputPathLocal
if $USBfound
   then reportFile=$outputPathUSB
   else reportFile=$outputPathLocal
fi

echo $reportFile

for node in $(seq 1 10) ;
   do

   echo processing n$node
   $pingTraceFile $node $reportFile

   done
echo 


