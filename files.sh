du -a / | sort -n -r | head -n 5
find / -type f -size +20M -exec ls -lh {} \; 2> /dev/null | awk '{ print $NF ": " $5 }' | sort -nk 2,2

find /proc/*/fd -ls | grep  '(deleted)'

##delete logs files last 30 days
find /var/log -name "*.log" -mtime +30 -exec rm -f {} \;

# cat without dash #
cat /etc/squid/squid.conf | egrep -v "(^#.*|^$)"
