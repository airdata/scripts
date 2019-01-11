#!/bin/bash

#
# SAMPLE redeploy static frontend in apache from zip
# ver 0.2 20161102
# rumenlishkoff@gmail.com
# 

if [ $# -lt 2 ]
then
        echo "Usage : $0 service-name filename"
	echo "valid service-names: [msc,lisa]"
        exit
fi

if [ ! -f $2 ]
then
        echo "Filename given \"$2\" doesn't exist"
        exit
fi

case "$1" in
	msc) SVC="msc"
	;;
	lisa) SVC="lisa"
	;;
	*) echo "Invalid service-name [$1] !"
	   exit
	;;
esac

echo "#"
echo "# SAS LABS Re-Deploy from Jenkins"
echo "#"
echo "# started $0 to re-deploy the $SVC frontend from $2"
echo "#"

echo "# [0] Stopping service Apache httpd ..."
act_1=`sudo /sbin/service httpd stop`
echo "## $act_1"

echo "# [1] Backing-up the actual $SVC frontend folder to /opt/$SVC/archive/bkp/"
act_2=`rm -fr /opt/$SVC/archive/bkp/www; mv -v /opt/$SVC/www /opt/$SVC/archive/bkp/; mkdir -pv /opt/$SVC/www`
echo "## $act_2"

echo "# [2] Installing the new $SVC frontend from $2"
act_3=`/usr/bin/unzip $2 -d /opt/$SVC/www/`
echo "## $act_3"

echo "# [3] Starging service Apache httpd ..."
act_4=`sudo /sbin/service httpd start`
echo "## $act_4"

#EOF
