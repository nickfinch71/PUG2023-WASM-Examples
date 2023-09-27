@echo off 

set basedir=%~dp0
set EXECUTABLE=PowerShell.exe -executionpolicy bypass -File "%basedir%/oesectool.ps1" %*

%EXECUTABLE%
