@echo off

rem building data...
pushd %~dp0\..\..
call Build_GameScripts.bat nopause
call buildData_ios.bat nopause
call buildData_server.bat nopause
call buildData_uwp.bat nopause
popd