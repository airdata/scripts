#!/bin/bash

#
# SAMPLE redeploy backend from file
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
echo "# started $0 to re-deploy the $SVC backend from $2"
echo "#"

echo "# [0] Stopping service $SVC..."
act_1=`sudo /sbin/service $SVC stop`
echo "## $act_1"

echo "# [1] Backing-up the actual $SVC backend to /opt/$SVC/archive/bkp/"
act_2=`mv -v /opt/$SVC/bin/$SVC.war /opt/$SVC/archive/bkp/`
echo "## $act_2"

echo "# [2] Installing the new $SVC backend from $2"
act_3=`mv -v $2 /opt/$SVC/bin/$SVC.war`
echo "## $act_3"

echo "# [3] Starging service $SVC..."
act_4=`sudo /sbin/service $SVC restart`
echo "## $act_4"

echo "# [4] Sleeping 1 min, please be patient ..."
sleep 60

echo "# [5] Dumping the last 200 lines from the unix-service LOG"
SVC_LOG=`cat /opt/$SVC/bin/$SVC.conf | grep LOG_FILENAME | cut -d "=" -f2`

tail -200 /opt/$SVC/log/$SVC_LOG



#EOF
