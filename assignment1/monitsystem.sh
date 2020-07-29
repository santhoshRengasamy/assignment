#! /bin/bash

# Check RAM Usages
free -h | grep -v + > /tmp/ramcache
cat /tmp/ramcache | grep -v "Swap"

# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
cat /tmp/diskusage
