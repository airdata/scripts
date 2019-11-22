#!/bin/bash

mysqldump --defaults-extra-file=/run/secrets/mycf-prod myp_wp_prod > /tmp/myp_wp_prod.sql
mysql --defaults-extra-file=/run/secrets/mycf-warm -r myp_wp_prod_warm < /tmp/myp_wp_prod.sql
rm -rf /tmp/myp_wp_prod.sql
rsync -auv --delete --exclude wp-config.php /prod/ /warm/
