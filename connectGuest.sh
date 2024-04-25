# Get this machine connected to VUWguest wifi.
# Steve Cosgrove 24 April 2024
# based on https://ubuntuforums.org/showthread.php?t=989860&page=4

# Precurser commands were something like:
# sudo wpa_cli -i wlan0 VUWguest
# sudo wpa_cli -i wlan0 status
# sudo wpa_cli -i wlan0 scan
# sudo wpa_cli -i wlan0 scan_results
# sudo wpa_cli -i wlan0 add_network
# sudo wpa_cli -i wlan0 set_network 6 ssid "VUWguest"
# sudo wpa_cli -i wlan0 status
# sudo wpa_cli -i wlan0 list_networks


sudo wpa_cli -i wlan0 set_network 0 key_mgmt NONE
sudo wpa_cli -i wlan0 enable_network 0
sudo wpa_cli -i wlan0 status
# sleep 30 
# wait 30 seconds for the network to get going
# then refresh the IP address
# to fix allocation of two IP address
sudo dhclient -r
