@echo off
REM navigate to win-scripts directory
cd /d %~dp0
powershell -ExecutionPolicy Bypass -File .\taskmgr.ps1
