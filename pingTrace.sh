# pingcount.sh Use pings to find distance from host to remote address
    # traceroute does not seem to give consistent results
#
# Parameters are <node to test> <report filename>
#
# created by Steve Cosgrove 21 October 2024

# put parameters into meaningful variables
thisNode=$1   # <node to test>
reportFile=$2 # <report filename>

# print name of current node -n means don't add newline
echo -n "$thisNode - " >>$reportFile
for COUNT in {1..10}
  do
    if [ $COUNT == 2 ] ; then PURAL=s ; fi # add 's' if more than one hop
    # ping node specified in command line '$1'
    # -c number of ping requests to send
    # -n don't resolve hostnames (save time, as we don't use them)
    # -w wait for this number of seconds for a reply
    # -t TTL - stop trying after this number of hops
    ping -c 3 -nw 15 $thisNode -t$COUNT &>/dev/null
    # '$?' is the return code from ping. It will equal number of
    #   successful pings. Will be equal to or less than -c value
    if [ $? == 1 ]
      then
        echo -n $COUNT,  >>$reportFile
      else
        echo    $COUNT hop$PURAL      >>$reportFile # This line prints one result per line
        break
      fi
  done

# Example of single line used to develop this code
# for COUNT in 1 2 3 4 5 6 7 ; do ping -c 1 -nw 2 $1 -t$COUNT ; if [ $? == 1 ] ; then echo  fail ; else echo worked at $COUNT ; break ; fi ; done | egrep "(worked|fail|limit)"

