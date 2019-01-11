@echo off

rem syncing to mac...
pushd %~dp0\..\sync
call setup.bat nopause %1 %2
call sync.bat nopause
popd