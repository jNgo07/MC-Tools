@echo off
xcopy "OCCT" "%USERPROFILE%\Desktop\OCCT" /e /c /i
start %USERPROFILE%\Desktop\OCCT\run-occt.bat & exit