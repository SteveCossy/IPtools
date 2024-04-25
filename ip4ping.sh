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

echo This is `hostname`

for DEV in $(seq 1 254) ;
   do
#      echo $DEV
   ping -c 1 -w 1 192.168.5.$DEV >/dev/null
   if [ $? -eq 0 ]
   then
#       RESULT=works
        echo
        echo -n $DEV works
	echo " "`date`
   else
#       RESULT=failed
        echo -n $DEV " "
   fi
done

echo

