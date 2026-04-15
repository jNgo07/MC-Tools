::::::::::::::::::::::::::::::::::::::::::::
:: MC Disk Corruption Check Script
:: v3.1.1 - 04.14.2026 - added headers to script files, muted output from run_cc.bat while getting admin mode
:: Runs DISM and SFC commands auotomatically without user input, logs output to user desktop as "MC_Corruption_Check.log"
:: Originally written by jPrice, modified by jNgo. refer to jPrice cc scripts for original versions
:: Refer to GitHub for update history and latest versions: https://github.com/jNgo07/MC-Tools
::::::::::::::::::::::::::::::::::::::::::::

@echo off
cls

:: create MC log file in same directory as script (desktop)
set LOGFILE=%USERPROFILE%\Desktop\MC_Corruption_Check.log

:: for testing, DEBUG 1: skip dism/sfc commands, just print lines
set DEBUG=0

:: log file header
echo =====================================  >> "%LOGFILE%"
echo Corruption Check Run: %date% %time%    >> "%LOGFILE%"
echo =====================================  >> "%LOGFILE%"
echo. >> "%LOGFILE%"

echo =====================================
echo  MC Corruption Check w/logger v3.1.1
echo =====================================
echo.

:: run DISM SCANHEALTH
echo Running DISM Scan...
if '%DEBUG%'=='0' (
    dism /online /cleanup-image /scanhealth
) else (
    echo DEBUG MODE: NOT RUNNING DISM, would run: "dism /online /cleanup-image /scanhealth"
)
echo.
echo copying output to log... please be patient
echo.

echo =====================  >> "%LOGFILE%"
echo [DISM ScanHealth]      >> "%LOGFILE%"
echo =====================  >> "%LOGFILE%"
if '%DEBUG%'=='0' (
    dism /online /cleanup-image /scanhealth >> "%LOGFILE%" 2>&1
) else (
    echo DEBUG MODE: NOT RUNNING DISM, would run: "dism /online /cleanup-image /scanhealth >> "%LOGFILE%" 2>&1" >> "%LOGFILE%"
)
echo. >> "%LOGFILE%"


::run DISM CHECKHEALTH
echo Running DISM check...
if '%DEBUG%'=='0' (
    dism /online /cleanup-image /checkhealth
) else (
    echo DEBUG MODE: NOT RUNNING DISM, would run: "dism /online /cleanup-image /checkhealth"
)
echo.
echo copying output to log... please be patient
echo.

echo =====================  >> "%LOGFILE%"
echo [DISM CheckHealth]     >> "%LOGFILE%"
echo =====================  >> "%LOGFILE%"
if '%DEBUG%'=='0' (
    dism /online /cleanup-image /checkhealth >> "%LOGFILE%" 2>&1
) else (
    echo DEBUG MODE: NOT RUNNING DISM, would run: "dism /online /cleanup-image /checkhealth >> "%LOGFILE%" 2>&1" >> "%LOGFILE%"
)
echo. >> "%LOGFILE%"


::run DISM RESTOREHEALTH
echo Running DISM restore...
if '%DEBUG%'=='0' (
    dism /online /cleanup-image /restorehealth
) else (
    echo DEBUG MODE: NOT RUNNING DISM, would run: "dism /online /cleanup-image /restorehealth"
)
echo.
echo copying output to log... please be patient
echo.

echo =====================  >> "%LOGFILE%"
echo [DISM RestoreHealth]   >> "%LOGFILE%"
echo =====================  >> "%LOGFILE%"
if '%DEBUG%'=='0' (
    dism /online /cleanup-image /restorehealth >> "%LOGFILE%" 2>&1
) else (
    echo DEBUG MODE: NOT RUNNING DISM, would run: "dism /online /cleanup-image /restorehealth >> "%LOGFILE%" 2>&1" >> "%LOGFILE%"
)
echo. >> "%LOGFILE%"

::double run SFC to ensure all repairs are done, only log last sfc
echo SFC ScanNow
if '%DEBUG%'=='0' (
    sfc /scannow
) else (
    echo DEBUG MODE: NOT RUNNING SFC, would run: "sfc /scannow"
)
echo.

echo.
echo Rerunning SFC, printing to log only. Please be patient.
echo Window will close on completion.
if '%DEBUG%'=='0' (
    sfc /scannow >> "%LOGFILE%" 2>&1
    echo. >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
) else (
    echo DEBUG MODE: NOT RUNNING SFC, would run: "sfc /scannow >> "%LOGFILE%" 2>&1" >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
    timeout /t 5 /nobreak >nul
)

echo.
echo.
echo Done^! Log saved to:
echo %LOGFILE%

timeout /t 5 /nobreak >nul
echo closing in 3 seconds...
timeout /t 3 /nobreak >nul
exit