#!/bin/bash

#to be parameterized
BUILD_FOLDER=$2
VERSION=$1
ARCHIVE_NAME="InstantWarLinuxServer_$VERSION.zip"
APP_NAME=ServerApp
APP_DEBUG_NAME=ServerApp.dbg
BACKUP_USER=atomic
BACKUP_PASSWORD=Buro_12
BACKUP_HOST=192.168.1.10
BACKUP_FOLDER=$3

#generate project
pushd "$BUILD_FOLDER/externals/engine"
./CMake_Server.sh
#workaround for discrepencies in cmake options, have to check it later
./CMake_Server.sh
popd

RELEASE_DIR="$BUILD_FOLDER/externals/engine/Artifacts/Server"
BUILD_OUTPUT_DIR="$BUILD_FOLDER/externals/engine-Build-Linux/Source/ServerApp"

#clear build
rm -f $RELEASE_DIR/$APP_NAME
rm -f $BUILD_OUTPUT_DIR/$APP_NAME

#build project
pushd "$BUILD_FOLDER/externals/engine-Build-Linux"
make ServerApp -j 6 || exit 1
popd

if [ "$?" != "0" ]; then
	echo "[Error] building"
	exit 1
fi

#copy app
mv $BUILD_OUTPUT_DIR/$APP_NAME $RELEASE_DIR/$APP_NAME

pushd $RELEASE_DIR

#strip debug
objcopy --only-keep-debug $APP_NAME $APP_DEBUG_NAME
strip --strip-debug --strip-unneeded $APP_NAME
objcopy --add-gnu-debuglink=$APP_DEBUG_NAME $APP_NAME

#compress app and resources
rm -f *.zip
zip -r -y "$ARCHIVE_NAME" $APP_NAME AtomicServer_Resources Settings $APP_DEBUG_NAME
popd

if [ "$?" != "0" ]; then
	echo "[Error] archiving"
	exit 1
fi

#copy to backup for archive
pushd $RELEASE_DIR
export RSYNC_PASSWORD=$BACKUP_PASSWORD
rsync -avz --progress ./$ARCHIVE_NAME $BACKUP_USER@$BACKUP_HOST::$BACKUP_FOLDER
popd

if [ "$?" != "0" ]; then
	echo "[Error] rsync"
	exit 1
fi

