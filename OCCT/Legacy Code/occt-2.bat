:: ==========================
:: Creation Date: 12/15/2023
:: Revision Date: 01/09/2025
:: Author: madcock@microcenter.com
:: ==========================
@echo off
:: Kill any open instances of OCCT if present
taskkill /f /im OCCT*
cls
title OCCT Enterprise+ Burn-In v1.1
color 0a
echo Enter Astea Work Order Number:
set /p "sv="
mkdir "%USERPROFILE%\Desktop\Micro Center %sv% QA Results\"
cls
echo.***********************************************
echo *       Astea Work Order:  %sv%       *
echo.***********************************************
echo.
echo.***********************************************
echo *     Micro Center Express ProBuild OCCT      *
echo *  stability testing will begin in 5 seconds. *
echo * To cancel or choose a different test, press *
echo *     any key within the next 5 seconds.      *
echo.***********************************************
timeout 10 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto menu
cls
goto express

:menu
cls
echo.***********************************************
echo *       Astea Work Order:  %sv%       *
echo.***********************************************
echo.
echo.***********************************************
echo *        Select a Certificate Schedule        *
echo.***********************************************
echo  1 - Express ProBuild (30 Minutes)
echo  2 - Custom Loop ProBuild Stability (1 Hour)
echo  3 - Custom Loop ProBuild Overnight (24 Hours)
echo  4 - DIAG CPU Only - 10 Minutes
echo  5 - DIAG RAM Only - 10 Minutes
echo  6 - DIAG GPU Only - 10 Minutes
echo  7 - DIAG Power Test - 2 Minutes
echo.***********************************************
echo.
echo Press X to cancel.
echo.
choice /c 1234567X
cls
if %errorlevel% == 1 goto express
if %errorlevel% == 2 goto multi30
if %errorlevel% == 3 goto multi24
if %errorlevel% == 4 goto DiagA
if %errorlevel% == 5 goto DiagB
if %errorlevel% == 6 goto DiagC
if %errorlevel% == 7 goto DiagD
if %errorlevel% == 8 goto cancelled
:express
echo Running Express ProBuild Certificate
%USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe customCertificate --name="Micro Center Express ProBuild" --title=%sv% --metadatas "Astea Work Order="%sv% --metadatas "Cert Type"="Express ProBuild" --save-upload-result=true --upload-result-file="%USERPROFILE%\Desktop\Micro Center %sv% QA Results\Burn In Results.json" --allow-ocbase-upload=true --auto-save-report=true --report-file="%USERPROFILE%\Desktop\Micro Center %sv% QA Results\Burn In Results.html" --auto-start=true --auto-close=true --auto-enable-sensors=true
goto end
:multi30
%USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe customCertificate --name="Micro Center Custom ProBuild 1HR" --title=%sv% --metadatas "Astea Work Order"=%sv% --metadatas "Cert Type"="Custom ProBuild 1HR" --save-upload-result=true --upload-result-file="%USERPROFILE%\Desktop\Micro Center %sv% QA Results\Burn In Results.json" --allow-ocbase-upload=true --auto-save-report=true --report-file="%USERPROFILE%\Desktop\Micro Center %sv% QA Results\Burn In Results.html" --auto-start=true --auto-close=true --auto-enable-sensors=true
goto end
:multi24
%USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe customCertificate --name="Micro Center Custom ProBuild 24HR" --title=%sv% --metadatas "Astea Work Order"=%sv% --metadatas "Cert Type"="Custom ProBuild 24HR" --save-upload-result=true --upload-result-file="%USERPROFILE%\Desktop\Micro Center %sv% QA Results\Burn In Results.json" --allow-ocbase-upload=true --auto-save-report=true --report-file="%USERPROFILE%\Desktop\Micro Center %sv% QA Results\Burn In Results.html" --auto-start=true --auto-close=true --auto-enable-sensors=true
goto end
:end
cls

cls
:: %USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe test --config="%USERPROFILE%\Desktop\OCCT\resources\configs\30m-burn-in.json" --auto-save-report=true --report-file="%USERPROFILE%\Desktop\Micro Center QA Results\Burn In Results.html" --auto-enable-sensors=true --auto-close=true
start C:\Users\Default\Desktop
xcopy "%USERPROFILE%\Desktop\Micro Center %sv% QA Results\" "C:\Users\Default\Desktop\Micro Center %sv% QA Results" /e /c /i
cls
color a0
echo Testing has completed. Verify results are present on the current desktop and the Default user desktop.
pause
goto END

:diagA :: CPU Only
cls
echo OCCT CPU Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "%USERPROFILE%\Desktop\OCCT Diagnostics\"
cls
start %USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe test --config="%USERPROFILE%\Desktop\OCCT\resources\configs\10min-cpu.json" --auto-save-report=true --report-file="%USERPROFILE%\Desktop\OCCT Diagnostics\CPU Test Results.html" --auto-enable-sensors=true
goto continue

:diagB :: RAM Only
cls
echo OCCT RAM Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "%USERPROFILE%\Desktop\OCCT Diagnostics\"
cls
start %USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe test --config="%USERPROFILE%\Desktop\OCCT\resources\configs\10min-mem.json" --auto-save-report=true --report-file="%USERPROFILE%\Desktop\OCCT Diagnostics\RAM Test Results.html" --auto-enable-sensors=true
goto continue

:diagC :: GPU Only
cls
echo OCCT GPU Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "%USERPROFILE%\Desktop\OCCT Diagnostics\"
cls
start %USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe test --config="%USERPROFILE%\Desktop\OCCT\resources\configs\10min-gpu.json" --auto-save-report=true --report-file="%USERPROFILE%\Desktop\OCCT Diagnostics\GPU Test Results.html" --auto-enable-sensors=true
goto continue

:diagD :: Power Test Only
cls
echo OCCT Power Test starting in 3 seconds. Press any key to cancel.
timeout 3 | findstr /e "[^0-9]0"
cls
if %errorlevel% == 1 goto cancelled
mkdir "%USERPROFILE%\Desktop\OCCT Diagnostics\"
cls
start %USERPROFILE%\Desktop\OCCT\resources\OCCTEnterprise.exe test --config="%USERPROFILE%\Desktop\OCCT\resources\configs\2min-power.json" --auto-save-report=true --report-file="%USERPROFILE%\Desktop\OCCT Diagnostics\Power Test Results.html" --auto-enable-sensors=true
goto continue

:continue :: Placeholder for future use
goto END

:cancelled :: Message sent when any test is cancelled
cls
color 0c
echo Stability testing cancelled.
timeout 2 | findstr /e "d"
rmdir "%USERPROFILE%\Desktop\OCCT Diagnostics\"
rmdir "%resultsdir%"

goto END

:END
color 0a
cls 
