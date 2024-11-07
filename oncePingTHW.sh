# Ping all nodes on the SfTI network (TI Board interface) once
# Steve Cosgrove 10 April 2024    Added wait for network 12 April
#
# for: for NAME [in WORDS ... ] ; do COMMANDS; done
#    Execute commands for each member in a list.
#
#   The `for' loop executes a sequence of commands for each member in a
#    list of items.  If `in WORDS ...;' is not present, then `in "$@"' is
#    assumed.  For each element in WORDS, NAME is set to that element, and
#    the COMMANDS are executed.
#    Exit Status:
#    Returns the status of the last command executed.
#while: while COMMANDS; do COMMANDS; done
#    Execute commands as long as a test succeeds.
#    Expand and execute COMMANDS as long as the final command in the
#    `while' COMMANDS has an exit status of zero.
#    Exit Status:
#    Returns the status of the last command executed.

echo -n This is `hostname`

# Wait for the network to be available
ip address | grep 2020
RESULT=$?
TIME=0
INTERVAL=2

while [ $RESULT -eq 1 ]
do
  ip address | grep 2020
  RESULT=$?
  echo Been waiting for $TIME seconds
  sleep $INTERVAL
  TIME=`expr $TIME + $INTERVAL`
done

# IPs="2020:abcd::212:4b00:1caa:423a 2020:abcd::212:4b00:1caa:3852 2020:abcd::212:4b00:1caa:3852 2020:abcd::212:4b00:29c7:01d5 2020:abcd::212:4b00:1ca0:f67f"
IPs="2020:abcd::212:4b00:1caa:3de6 2020:abcd::212:4b00:1caa:423a 2020:abcd::212:4b00:1caa:3852 2020:abcd::212:4b00:1ca0:f67f 2020:abcd::212:4b00:14f9:419e 2020:abcd::212:4b00:29c7:01d5"

# echo $IPs

for DEV in $IPs ;
   do
#      echo $DEV
   ping6 -c 1 -w 3 $DEV >null
   if [ $? -eq 0 ]
      then RESULT=works
      SPEED=`ping6 -c 10 -w 1 -s 200 $DEV | grep rtt`

      echo `date` " " $RESULT  " " $DEV " " $SPEED
#      ping6 -c 10 -w 1 -s 200 $DEV | grep rtt 

      else RESULT=failed

      echo `date` " " $RESULT " " $DEV " "

   fi

done

echo
#sleep 5

#done
