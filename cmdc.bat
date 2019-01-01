@echo off
title CMD-Cleaner 2
if %1==main goto main
if %1==cache goto cache
if %1==cupdate goto cleanupdate
if %1==clear goto clear
if %1==help goto help
if %1==install goto install
echo.
echo **********************
echo Official CMD-Cleaner
echo **********************
echo.
echo Can not find command.
goto ende2

:install
echo Installing CMD-Cleaner...
copy cmdc.exe C:\Users\%Username%
cd/d C:\Users\%username%
if not exist cmdc.exe goto ende2
echo Installed successfully.
goto ende2

:cleanupdate
echo.
echo **********************
echo Official CMD-Cleaner
echo **********************
echo.
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
goto ende2

:cache
echo.
echo **********************
echo Official CMD-Cleaner
echo **********************
echo.
echo Cleaning cache...
ipconfig /flushdns
echo FreeMem = Space(1000) >ramclean.vbs
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 8
start ramclean.vbs
timeout/t 1 >nul
del ramclean.vbs
if not exist cmdcleaner mkdir cmdcleaner
cd/d cmdcleaner
if not exist temp mkdir temp
copy C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log %appdata%\so >nul
del C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q >nul
copy C:\Windows\Temp\*.tmp %appdata%\so\temp >nul
del C:\Windows\Temp\*.tmp /s /q >nul
echo off | clip
goto ende2


:main
echo.
echo **********************
echo Official CMD-Cleaner
echo **********************
echo.
echo Cleaning some stuff...
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 8
rundll32.exe  InetCpl.cpl,ClearMyTracksByProcess 255
ipconfig /flushdns
rd /s /q c:\$Recycle.Bin >nul
echo off | clip
cd %appdata%
echo FreeMem = Space(1000) >ramclean.vbs
start ramclean.vbs
timeout/t 1 >nul
del ramclean.vbs
if not exist cmdcleaner mkdir cmdcleaner
cd/d cmdcleaner
if not exist temp mkdir temp
copy C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log %appdata%\so >nul
del C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q >nul
copy C:\Windows\Temp\*.tmp %appdata%\so\temp >nul
del C:\Windows\Temp\*.tmp /s /q >nul
echo.
echo + System is now optimized!
echo.
goto ende

:help
echo.
echo    **********************
echo     Official CMD-Cleaner
echo    **********************
echo    (C) Luca Franziskowski
echo.
echo main     = Main-Cleaner
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
del C:\Users\%username%\Downloads\*.* /s /q
ipconfig /flushdns
rd /s /q c:\$Recycle.Bin
del C:\Users\%Username%\AppData\Local\Microsoft\Windows\WebCache\*.log 
echo off | clip
echo traces are now deleted!
goto ende


:ende
echo         ***** Information *******
echo If a few messages appear, try to run as admin.
echo Error-Messages are not critical, so you can
echo ignore them without worries...
echo **********************************************
echo Thanks for using the CMD-Cleaner!
echo **********************************************
echo.
:ende2