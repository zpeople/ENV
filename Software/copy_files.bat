REM @echo off &setlocal enabledelayedexpansion
cd /d %~dp0
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit
rem echo 当前目录:%~dp0
set DestPath=%~dp0

rem tarDir
set tarDir=%DestPath%UE5_DemoTemplate\Binaries\Win64

mkdir %tarDir%


pause
set dir1=%DestPath%Test
set d=1 

for /l %%i in (1,1,%d%) do (xcopy %dir1% %tarDir% /e /i /y)
pause
goto end



