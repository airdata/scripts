#!/bin/bash
# A sample Bash script, that update wordpress.

echo "Backup WP folder to /html.tar.gz...."
cd /var/www/ingicare.com/ && tar -zcvf /html.tar.gz .
echo "Clean old version files and unused plugins..."
rm -rf wp-admin wp-includes wp-content/plugins/ssh-sftp-updater-support
echo "Download && upgrade WP....."
cd /tmp && curl -O https://wordpress.org/latest.zip && unzip latest.zip && rm -rf wordpress/wp-content && mv -f wordpress/* /var/www/ingicare.com/
cd  /var/www/ingicare.com/
chown -R www-data:www-data .
echo "Fixing account permissions..."
find . -type f -exec chmod 664 {} \;
find . -type d -exec chmod 775 {} \;
echo "Clean files..."
rm -rf /tmp/wordpress && rm -rf /tmp/latest.zip
find . -name "readme*"  -exec rm -f {} \;
find . -name "license*"  -exec rm -f {} \;
