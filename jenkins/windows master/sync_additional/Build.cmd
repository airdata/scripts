@echo off

set ROOT=%~dp0
set TRUNK_PATH=%ROOT%Trunk\
set SYNC_PATH=%TRUNK_PATH%externals\sync\

echo.
echo ======================================
echo Build game scripts
echo ======================================

pushd %TRUNK_PATH%
call Build_GameScripts.bat nopause
if not errorlevel 1 goto error
popd


echo.
echo ======================================
echo Build data
echo ======================================

pushd %TRUNK_PATH%
rem call buildData.bat nopause
popd


echo.
echo ======================================
echo Build iOS data
echo ======================================

pushd %TRUNK_PATH%
call buildData_ios.bat nopause
popd


echo.
echo =======================================
echo Sync to OSX and create XCode project
echo =======================================

set "host=192.168.44.129"

ping -n 1 "%host%" | findstr /r /c:"[0-9] *ms"

if %errorlevel% == 0 (
	echo Sync to OSX machine.
	echo.

	pushd %SYNC_PATH%
	call %SYNC_PATH%sync.bat	
	popd

	rem Create XCode project
	rem cmd /c "bash -c ls"
	rem
) else (
	echo Sync FAILURE OSX machine is not started.
)

goto success

:error
echo.
echo.
echo ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR
echo.
echo.

:success
echo.
echo.
echo SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS
echo.
echo.

:end
