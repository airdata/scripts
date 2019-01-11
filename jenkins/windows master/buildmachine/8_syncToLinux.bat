@echo off

rem syncing to mac...
pushd %~dp0\..\sync
call setup_server.bat nopause %1 %2
call sync_server.bat nopause
popd