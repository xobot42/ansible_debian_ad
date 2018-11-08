#!/bin/sh

# local configuration options

# Note: modify at your own risk!  If you do/use anything in this
# script that is not part of a stable API (relying on files to be in
# specific places, specific tools, specific output, etc) there is a
# possibility you will end up with a broken system after patching or
# upgrading.  Changes are not supported unless under direction of
# VMware support.

# Note: This script will not be run when UEFI secure boot is enabled.

/bin/cp /scratch/smart/* / -R
/bin/esxcli network firewall refresh
/bin/kill $(cat /var/run/crond.pid)
/bin/echo "*/10 * * * * /usr/bin/python /opt/pyzabbix2_send_smart.py" >> /var/spool/cron/crontabs/root
/bin/crond


exit 0
