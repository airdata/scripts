wget http://repo.zabbix.com/zabbix/3.2/rhel/6/x86_64/zabbix-agent-3.2.0-1.el6.x86_64.rpm
rpm -i zabbix-agent-3.2.0-1.el6.x86_64.rpm && rm -rf /etc/logrotate.d/zabbix-agent*
cat << EOF >/etc/logrotate.d/zabbix-agent
/var/log/zabbix/zabbix_agentd.log {
    daily
    rotate 10
    compress
    delaycompress
    missingok
    notifempty
    create 0664 zabbix zabbix
}
EOF
sed -i -e 's/Server=127.0.0.1/Server=zabbix.lab/g' /etc/zabbix/zabbix_agentd.conf
sed -i -e 's/ServerActive=127.0.0.1/#ServerActive=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf
vim +147 /etc/zabbix/zabbix_agentd.conf
/etc/init.d/zabbix-agent restart
