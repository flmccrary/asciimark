@echo off
setlocal
set "mode=edit"
if /I "%~1"=="--view" set "mode=view"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0launch.ps1" "%mode%"
set "exitCode=%ERRORLEVEL%"
endlocal & exit /b %exitCode%