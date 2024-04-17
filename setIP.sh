# Change machine name to match DNS name from hosts file
# Steve Cosgrove 9 April 2024    Added wait for network 12 April

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


ipAddress=$(ip addre | grep '2020' | awk '{print $2}')
ipAddress=${ipAddress::-3}
echo $ipAddress
hostnameNew=$(grep $ipAddress /etc/hosts | awk -F' ' '{ print $2 }')

hostnameCurrent=`hostname`

echo $hostnameCurrent
echo $DNS
echo $hostnameNew

sed s/$hostnameCurrent/$hostnameNew/ /etc/hosts > ~/hosts.new
sed s/$hostnameCurrent/$hostnameNew/ /etc/hostname > ~/hostname.new
sudo cp ~/hosts.new /etc/hosts
sudo cp ~/hostname.new /etc/hostname
