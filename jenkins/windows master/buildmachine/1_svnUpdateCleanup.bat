@echo off

set SVN_USERNAME=build.machine
set SVN_PASSWORD=B12_games
set CLEAN=%1

pushd %~dp0\..\..

@echo Updating...
svn update --non-interactive --trust-server-cert --accept=theirs-full --username %SVN_USERNAME% --password %SVN_PASSWORD%

@echo Cleanup...
if "%CLEAN%"=="noclean" (
	svn cleanup --non-interactive --include-externals
) else (
	svn cleanup --non-interactive --remove-unversioned --remove-ignored --include-externals
)

@echo Reverting...
svn revert -R .

popd