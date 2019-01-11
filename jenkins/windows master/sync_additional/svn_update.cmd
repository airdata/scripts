@echo off

set ROOT=%~dp0
set TRUNK_PATH=%ROOT%Trunk\
set ENGINE_PATH=%TRUNK_PATH%externals\engine\
set PROJECT_PATH=%TRUNK_PATH%externals\engine-VS2017\

echo.
echo ======================================
echo Pull latest SVN version
echo ======================================

pushd %TRUNK_PATH%
call svn update
if not errorlevel 0 goto error
popd

echo.
echo ======================================
echo Generate CMake files
echo ======================================

pushd %ENGINE_PATH%
call CMake_VS2017.bat
if not errorlevel 0 goto error
popd


echo.
echo ======================================
echo Build lates version 
echo ======================================

pushd %ENGINE_PATH%
rem call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
if not errorlevel 0 goto error
popd


rem ======================================
rem Error handling
rem ======================================
goto success

:error
echo.
echo.
echo ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR
echo.
echo.
goto end

:success
echo.
echo.
echo SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS
echo.
echo.

:end
