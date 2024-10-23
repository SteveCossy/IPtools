while true ; do systemctl status tund-manager.service ; sleep 60 ; done | tee -a TunWatch-`date +%F,%H:%M`
