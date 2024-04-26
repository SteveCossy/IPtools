# List leases currently recorded in the leases file
# Steve Cosgrove 26 April 2024

echo Leases currently recorded for this machine\'s DHCP server
cat /var/lib/misc/dnsmasq.leases

echo
echo To check for machines currently responding, run something like:
echo $0 ip4ping.sh
echo or
echo `pwd`/ip4ping.sh
