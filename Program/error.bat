@echo off
chcp 65001 > nul

title Agotik Launcher - ОШИБКА
color 3f
mode con: cols=120 lines=30


::Текст
start Music2.vbs
cls
echo      ^/
echo •   ^|
echo     ^|
echo •   ^|
echo      ^\
echo.
echo В приложении вознакла проблема и её необходимо исправить.
echo Настройки приложения были сброшены на значение по умолчанию.
echo За дополнительной поддержкой можно обратиться через функцию "Связаться со мной"
echo или написать на почту tshopizyt@gmail.com
echo.
echo Информация об ошибке находится на вашем рабочем столе.
echo.
cd %~dp0
rmdir /q /s settings
rmdir /q /s ConReg
::Создаю крашлог
set "crashlog=%1"



echo ===== Agotik Launcher Crashlog ===== > %crashlog%
echo Crash date: %date% >> %crashlog%
echo Crash time: %time:~0,-3% >> %crashlog%
echo TIMEZONE info: >> %crashlog%
wmic timezone >> %crashlog%
echo ==================================== >> %crashlog%
echo CPU info: >> %crashlog%
wmic cpu >> %crashlog%
echo ==================================== >> %crashlog%
echo BIOS info: >>%crashlog%
wmic bios >> %crashlog%
echo ==================================== >> %crashlog%



pause
taskkill /f /im powershell.exe
reg import "Error restore.reg"
exit