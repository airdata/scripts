#!/usr/bin/env sh

#set path to cmake
PATH="/Applications/CMake.app/Contents/bin":"$PATH"

#to be parameterized
MAC_FOLDER=$2
VERSION=$1
ARCHIVE_NAME="InstantWar_$VERSION.zip"
ARCHIVE_NAME_DSYM="InstantWar_$VERSION.dSYM.zip"
APP_NAME=InstantWar.app
DSYM_NAME=InstantWar.app.dSYM
BACKUP_USER=atomic
BACKUP_PASSWORD=Buro_12
BACKUP_HOST=192.168.1.10
BACKUP_FOLDER=$3

#generate project
pushd "$MAC_FOLDER/externals/engine"
./CMake_iOS.command
#workaround for discrepencies in cmake options, have to check it later
./CMake_iOS.command
popd

RELEASE_DIR="$MAC_FOLDER/externals/AtomicGameEngine-iOS/Source/AtomicPlayer/Application/Release-iphoneos"
rm -fr $RELEASE_DIR

#build xcode project
pushd "$MAC_FOLDER/externals/AtomicGameEngine-iOS"
security unlock-keychain -p 123
xcodebuild -target AtomicPlayer -configuration Release -parallelizeTargets -jobs 4 || exit 1
popd

if [ "$?" != "0" ]; then
	echo "[Error] building"
	exit 1
fi

#compress app and dsym
pushd $RELEASE_DIR
rm -f *.zip
zip -r -y "$ARCHIVE_NAME" "$APP_NAME"
zip -r -y "$ARCHIVE_NAME_DSYM" "$DSYM_NAME"
popd

if [ "$?" != "0" ]; then
	echo "[Error] archiving"
	exit 1
fi

#copy to backup for archive
pushd $RELEASE_DIR
export RSYNC_PASSWORD=$BACKUP_PASSWORD
rsync -avz --progress ./$ARCHIVE_NAME $BACKUP_USER@$BACKUP_HOST::$BACKUP_FOLDER
rsync -avz --progress ./$ARCHIVE_NAME_DSYM $BACKUP_USER@$BACKUP_HOST::$BACKUP_FOLDER
popd

if [ "$?" != "0" ]; then
	echo "[Error] rsync"
	exit 1
fi

