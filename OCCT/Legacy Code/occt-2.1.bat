:: ==========================
:: Creation Date: 12/15/2023
:: Revision Date: 12/22/2023
:: Author: M. Adcock - SrvOps
:: ==========================
@echo off
:: Kill any open instances of OCCT if present
taskkill /f /im OCCT*
cls
title OCCT Burn-In v0.3
color 0a

:optionA :: Full stress test/burn-in - Runs automatically if no interaction
cls
echo OCCT Stability Testing Starting in 30 seconds. Press any key to open specific component diagnostic testing menu.
timeout 30 | findstr /e "[^0-9]0"
if %errorlevel% == 1 goto optionB
mkdir "C:\Micro Center QA Results\"
cls
C:\OCCT\resources\OCCTEnterprise.exe test --config="C:\OCCT\resources\configs\30m-burn-in.json" --auto-save-report=true --report-file="C:\Micro Center QA Results\Burn In Results.html" --auto-enable-sensors=true --auto-close=true
start C:\OCCT
cls
color a0
echo Testing has completed. Verify results are present on the current desktop and the Default user desktop.
pause
goto END

:optionB :: Single phase testing
cls
echo Select an option to continue:
echo 1 - CPU Only - 10 Minutes
echo 2 - RAM Only - 10 Minutes
echo 3 - GPU Only - 10 Minutes
echo 4 - Power Test - 2 Minutes
echo X - Cancel
choice /c 1234X
if %errorlevel% == 1 goto diagA
if %errorlevel% == 2 goto diagB
if %errorlevel% == 3 goto diagC
if %errorlevel% == 4 goto diagD
if %errorlevel% == 5 goto cancelled

:diagA :: CPU Only
cls
echo OCCT CPU Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "C:\OCCT Diagnostics\"
cls
start C:\OCCT\resources\OCCTEnterprise.exe test --config="C:\OCCT\resources\configs\10min-cpu.json" --auto-save-report=true --report-file="C:\OCCT Diagnostics\CPU Test Results.html" --auto-enable-sensors=true
goto continue

:diagB :: RAM Only
cls
echo OCCT RAM Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "C:\OCCT Diagnostics\"
cls
start C:\OCCT\resources\OCCTEnterprise.exe test --config="C:\OCCT\resources\configs\10min-mem.json" --auto-save-report=true --report-file="C:\OCCT Diagnostics\RAM Test Results.html" --auto-enable-sensors=true
goto continue

:diagC :: GPU Only
cls
echo OCCT GPU Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "C:\OCCT Diagnostics\"
cls
start C:\OCCT\resources\OCCTEnterprise.exe test --config="C:\OCCT\resources\configs\10min-gpu.json" --auto-save-report=true --report-file="C:\OCCT Diagnostics\GPU Test Results.html" --auto-enable-sensors=true
goto continue

:diagD :: Power Test Only
cls
echo OCCT Power Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "C:\OCCT Diagnostics\"
cls
start C:\OCCT\resources\OCCTEnterprise.exe test --config="C:\OCCT\resources\configs\2min-power.json" --auto-save-report=true --report-file="C:\OCCT Diagnostics\Power Test Results.html" --auto-enable-sensors=true
goto continue

:continue :: Placeholder for future use
goto END

:cancelled :: Message sent when any test is cancelled
cls
color 0c
echo Stability testing cancelled.
timeout 2 | findstr /e "d"
rmdir "C:\OCCT Diagnostics\"
goto END

:END
color 0a
cls 
