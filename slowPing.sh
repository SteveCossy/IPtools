# Testing conectivity to one site periodically
# Steve Cosgrove 24 April 2024
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

DESTINATION=bbc.com

while :
do

   ping -c 1 -w 2 $DESTINATION >/dev/null
   if [ $? -eq 0 ]
      then RESULT=works
      else RESULT=failed
   fi
   echo -n $DESTINATION : $RESULT
   echo " "`date`
   echo
   sleep 5

done
