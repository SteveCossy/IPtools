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



for DEV in $(seq 1 10) ;
   do
#      echo $DEV
   ping6 -c 1 -w 1 n$DEV >null
   if [ $? -eq 0 ]
      then RESULT=works
      else RESULT=failed
   fi
   echo -n Node $DEV: $RESULT
   echo " "`date`

done

echo
#sleep 5

#done
