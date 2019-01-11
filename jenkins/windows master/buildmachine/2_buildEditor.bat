@echo off

::get current game revision
pushd %~dp0\..\..
for /f "tokens=1,2 delims=:" %%i in ('svn info .') do (
	if "%%i"=="Revision" (
		set /a SVN_REVISION_GAME=%%j
	)
)
popd

::get current engine revision
pushd %~dp0\..\engine
for /f "tokens=1,2 delims=:" %%i in ('svn info .') do (
	if "%%i"=="Revision" (
		set /a SVN_REVISION_ENGINE=%%j
	)
)
popd

::compiling...
pushd %~dp0\..\engine
call Build_AtomicEditor.bat --nonet --opengl --noclean --console
popd

if %errorlevel% GEQ 1 exit /B %errorlevel%

::synchronize folder to release
pushd %~dp0\..\sync
set SRC=%~dp0\..\engine\Artifacts\AtomicEditor
set DST=%~dp0\..\editor
call synchronize_folder.bat %SRC% %DST%
popd

::svn add/delete/commit
pushd %~dp0\..\editor

::add all unversioned files
svn add . --force --auto-props --parents --depth infinity --no-ignore -q 

::delete all missing files
svn status | findstr /R "^!" > missing.list
for /F "tokens=2 delims= " %%A in (missing.list) do (
    svn delete %%A
)
del missing.list

::commit
svn commit --message "-Editor release built from Game r%SVN_REVISION_GAME% Engine r%SVN_REVISION_ENGINE%"

popd