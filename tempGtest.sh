
ip address | grep 2020
RESULT=$?

while [ $RESULT -eq 1 ]
do
  echo "Still waiting"
  ip address | grep 2020
  RESULT=$?
  sleep 5
done



#if echo  grep -q 2020 `ip address` ; then
#    echo "MATCH"
#else
#    echo "Not Ready"
#fi
