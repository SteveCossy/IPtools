# Infinitely repeat testing conectivity of all nodes on SfTI Network
# Steve Cosgrove 11 April 2024
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

while :
do

for DEV in $(seq 1 11) ;
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
sleep 5

done
