# List devices on the local network
ssh admin@192.168.5.5 ip dhcp-server lease print | grep -v waiting
