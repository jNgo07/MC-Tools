@echo off
cls
@echo Corruption Check v1.2
@echo.
@echo Running DISM Scan...
@dism /online /cleanup-image /scanhealth
@echo.
@echo Running DISM check...
@dism /online /cleanup-image /checkhealth
@echo.
@echo Running DISM restore...
@dism /online /cleanup-image /restorehealth
@echo.
@echo Running SFC...
@sfc/scannow
@echo.
@echo Rerunning SFC...
@sfc/scannow
@echo.
@ECHO OFF
:start
SET choice=
SET /p choice=Run WinGet? [Y/N]: 
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='Y' GOTO yes
IF '%choice%'=='y' GOTO yes
IF '%choice%'=='N' GOTO no
IF '%choice%'=='n' GOTO no
IF '%choice%'=='' GOTO no
ECHO "%choice%" is not valid
ECHO.
GOTO start

:no
ECHO All done!
PAUSE
EXIT

:yes
ECHO Running WinGet
@winget upgrade --all
@echo All done!
pause