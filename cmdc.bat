@echo off
title CMD-Cleaner
echo.
echo **********************
echo   Simple CMD-Cleaner
echo **********************
echo.
if "%1"=="main" goto main
if "%1"=="cache" goto cache
if "%1"=="cupdate" goto cleanupdate
if "%1"=="clear" goto clear
if "%1"=="help" goto help
echo.
echo Command not found.
goto eof


:cleanupdate
echo Repairing Windows-Updater...
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 Catroot2.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
wuauclt /resetauthorization
wuauclt /detectnow 
goto eof

:cache
echo Cleaning cache...
ipconfig /flushdns
:: echo FreeMem = Space(1000) >ramclean.vbs Doesnt work on Windows 11 anymore...
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 8
:: start ramclean.vbs
:: timeout/t 1 >nul
:: del ramclean.vbs /s /q
if not exist "%temp%\cmdcleaner" mkdir "%temp%\cmdcleaner"
move "C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log" "%temp%\cmdcleaner" >nul
:: del C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q >nul
move "C:\Windows\Temp\*.tmp" "%temp%\cmdcleaner" >nul
del C:\Windows\Temp\*.tmp /s /q >nul
echo off | clip
goto ende2


:main
echo Cleaning some junk-files...
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 8
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 255
ipconfig /flushdns
rd /s /q c:\$Recycle.Bin >nul
echo off | clip
echo FreeMem = Space(1000) >"%appdata%\ramclean.vbs"
start "%appdata%\ramclean.vbs"
timeout/t 1 >nul
del "%appdata%\ramclean.vbs" /s /q
if not exist "%temp%\cmdcleaner" mkdir "%temp%\cmdcleaner"
move C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log "%temp%\cmdcleaner" >nul
:: del C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q >nul
move C:\Windows\Temp\*.tmp "%temp%\cmdcleaner" >nul
:: del C:\Windows\Temp\*.tmp /s /q >nul
echo.
echo Process is done.
echo.
goto ende

:help
echo.
echo main     = Main cleaning-process
echo cache    = Cleans all sorts of cache
echo clear    = Clear Browser-History
echo           (only IExplorer)
echo cupdate  = Delete Windows 10 Update Cache
echo help     = Shows this help-message
echo.
goto ende2


:clear 
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 8
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 255
del C:\Users\"%username%"\Downloads\*.* /s /q
ipconfig /flushdns
rd /s /q c:\$Recycle.Bin
if exist "C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log" del "C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log" /s /q
echo off | clip
echo Junk-Files have been deleted.
goto ende


:ende
echo.
echo.
echo         ***** Information *******
echo If a few messages appear, try to run as admin.
echo Error-Messages are not critical, so you can
echo ignore them without any worries...
echo **********************************************
echo.
:eof
