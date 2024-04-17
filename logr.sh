# Set up this node to rotate the tund logs on each reboot
# Steve Cosgrove 10 April 2024 - update 12 April 3:16

# Move our logrotate config file to the correct directory
sudo cp ~/IPtools/rotateTundLog  /etc/logrotate.d/

echo @reboot /usr/sbin/logrotate --force /etc/logrotate.d/rotateTundLog
read -p "Copy the line above to paste into crontab. Hit enter to continue"

sudo crontab -e
