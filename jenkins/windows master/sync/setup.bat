@echo off

pushd "%~dp0"
if not exist ..\sync_config mkdir ..\sync_config
if not exist ..\sync_config\config.bat call :copy_config_bat %2 %3
if not exist ..\sync_config\hlp_rsync_includeFilter.txt call :hlp_rsync_includeFilter
if not exist ..\sync_config\hlp_rsync_excludeFilter.txt call :hlp_rsync_excludeFilter
popd
goto :endpause

:copy_config_bat
if "%1"=="" (
	copy config.bat.template ..\sync_config\config.bat > nul
) else (
	echo @echo off > ..\sync_config\config.bat
	echo set USERNAME=admin>> ..\sync_config\config.bat
	echo set PASSWORD=123>> ..\sync_config\config.bat
	echo set HOST=%1>> ..\sync_config\config.bat
	echo set DST_FOLDER=%2>> ..\sync_config\config.bat
)
goto :eof

:hlp_rsync_includeFilter
copy /y nul ..\sync_config\hlp_rsync_includeFilter.txt
goto :eof

:hlp_rsync_excludeFilter
copy /y nul ..\sync_config\hlp_rsync_excludeFilter.txt
goto :eof

:endpause
if "%1"=="nopause" goto end
pause
:end