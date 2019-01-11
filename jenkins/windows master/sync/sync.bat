@echo off

call %~dp0/../sync_config/config.bat

::detect project root folder in cygwin style 
set DL=%cd:~0,1%
set P=%~p0../../
set P=%P:\=/%
set PRJ_PATH=/cygdrive/%DL%%P%

set PLINK="%~dp0/plink.exe"
set RSYNC="%~dp0/rsync.exe"
set RSH='%PLINK% -l %USERNAME% -pw %PASSWORD%'
set SRC='%PRJ_PATH%'
set DST='%USERNAME%@%HOST%:%DST_FOLDER%'

%PLINK% -ssh %HOST% -l %USERNAME% -pw %PASSWORD% exit

%RSYNC% -uparzv --chmod=ugoa=rwx --progress --rsh %RSH% --exclude-from=../sync_config/hlp_rsync_excludeFilter.txt --files-from=../sync_config/hlp_rsync_includeFilter.txt %SRC% %DST%

if "%1"=="nopause" goto end
pause
:end
