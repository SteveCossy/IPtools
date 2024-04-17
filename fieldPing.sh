# Ping all nodes on the SfTI network (TI Board interface) once
#
# Steve Cosgrove 17 April 2024    Modified from oncePing.sh to reduce output and place it on Jetson USB storage
#
# This file should be downloaded to ~/IPtools/ and permissions changed so we can run it
#
# cd ~/IPtools
# wget https://raw.githubusercontent.com/SteveCossy/IPtools/master/fieldPing.sh
# chmod a+x fieldping.sh
#
# The following lines can be used to run this script every 30 minutes
# sudo crontab -e
# ... add this line to the end of the existing crontab file:
# */30 * * * * /home/jetson/IPtools/fieldPing.sh
#
# The results can be viewed with:
# cat <outputPath>
# where outputPath is a concatination of the output USB, Folder, and File below
# eg cat /media/jetson/KINGSTON/networking/pingTest
#

outputUSB=/media/jetson/KINGSTON
outputFolder=/networking
outputFile=/pingTest

outputPath=$outputUSB$outputFolder$outputFile

if [ ! -d $outputUSB ]
then
    echo USB device not found
else

    # Create a new folder if necessary.  No error message if the folder doesn't work
    sudo mkdir -p $outputUSB$outputFolder

    echo Connectivity check from `hostname` at `date` | sudo tee -a $outputPath

    # Wait for the network to be available
    ip address | grep 2020
    RESULT=$?
    TIME=0
    INTERVAL=3
    threshold=240

    while [ $RESULT -eq 1 ]
    do
      if [ $TIME -eq 0 ]
          then echo Local IP address not found, waiting | sudo tee -a $outputPath
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

    for node in $(seq 1 10) ;
       do
       ping6 -c 1 -w 3 n$node >/dev/null
       if [ $? -eq 0 ]
          then RESULT=works
          else RESULT=failed
       fi
       echo -n "Node $node: $RESULT; " | sudo tee -a $outputPath

    done

echo | sudo tee -a $outputPath
echo | sudo tee -a $outputPath

fi
