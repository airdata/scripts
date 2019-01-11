@echo off

set SRC=%1
set DST=%2

if "%SRC%"=="" goto end
if "%DST%"=="" goto end

pushd %SRC%
::detect project root folder in cygwin style 
set DL=%~d1
set DL=%DL:~0,1%
set P=%~p1
set N=%~n1
set P=%P:\=/%
set SRC_PATH='/cygdrive/%DL%%P%%N%/'
popd

pushd %DST%
::detect project root folder in cygwin style 
set DL=%~d2%
set DL=%DL:~0,1%
set P=%~p2
set N=%~n2
set P=%P:\=/%
set DST_PATH='/cygdrive/%DL%%P%%N%'
popd

set RSYNC=rsync.exe
%RSYNC% -parzvc --delete --exclude='.svn*' --exclude='*.pdb' --exclude='*.ilk' %SRC_PATH% %DST_PATH%
