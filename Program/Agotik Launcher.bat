@echo off
chcp 65001>nul
setlocal
setlocal EnableDelayedExpansion
VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL==1 (
	call :PrintRed "Не удаётся включить расширенную обработку команд!"
	pause
	exit /b 5
)
if "%1"=="al://dir/" (
	start %windir%\explorer.exe "%~dp0"
	exit
)
title Agotik Launcher - Запрос прав администратора...
if not "%1"=="admin" (
	echo Запрос прав администратора...
	powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin %username%\"' -Verb RunAs"
	exit /b
)
title Agotik Launcher - Выполняется первоначальная настройка...
::SET
set "LOCAL_VERSION=Pre-release 2.01"
set "this.d=%~dp0"
set "this.d=%this.d:~0,-1%"
set "this=%~f0"
set bin=%this.d%\bin
set startusername=%2
::SETTINGS
cd %this.d%
mkdir ConReg
reg export HKCU\Console Console.reg > nul
move /y Console.reg ConReg\Console.reg > nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v WindowPosition /t REG_DWORD /d 0 /f > nul
cls

::PRODUCTS
cd %this.d%
if not exist bin (
	mkdir bin
)

::Games
if not exist Games (
	mkdir Games
)

::LINK
reg delete HKCR\AL /f > nul
reg add HKCR\AL > nul
reg add HKCR\AL /f /v "URL Protocol" /t REG_SZ /d "" > nul
reg add HKCR\AL\shell > nul
reg add HKCR\AL\shell\open > nul
reg add HKCR\AL\shell\open\command > nul
reg add HKCR\AL\shell\open\command /f /ve /t REG_SZ /d "%this% %%1" > nul


:menu
::LOGO
cd %this.d%
if not exist settings (
	mkdir settings
	cd settings
	mkdir logo
	cd logo
	echo. >1
	cls
	echo Перезапустите приложение.
	pause
	exit /b
) else (
	cd settings\logo
	for /f "delims=" %%a in ('dir /b') do (
		set "logo=%%a"
	)
)


::COLOR
cd %this.d%\settings
if not exist color (
	mkdir color
	cd color
	mkdir 1
	cd 1
	echo. >0
	cd ..
	mkdir 2
	cd 2
	echo. >7
	cls
	echo Перезапустите приложение.
	pause
	exit /b
) else (
	cd color\1
	for /f "delims=" %%a in ('dir /b') do (
		set "col1=%%a"
	)
	cd ..\2
	for /f "delims=" %%a in ('dir /b') do (
		set "col2=%%a"
	)
)


goto program


:logo1
mode con: cols=55 lines=35
echo ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
echo ░░██████╗██████╗██████╗██████╗██████╗██████╗██████╗░░░
echo ░░╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝░░░
echo ░░██████╗██████╗██████╗██████╗██████╗██████╗██████╗░░░
echo ░░╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝░░░
echo ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
echo ░░░░░░████████╗░██████╗██╗░░██╗░█████╗░██████╗░░░░░░░░
echo ░░░░░░╚══██╔══╝██╔════╝██║░░██║██╔══██╗██╔══██╗░░░░░░░
echo ░░░░░░░░░██║░░░╚█████╗░███████║██║░░██║██████╔╝░░░░░░░
echo ░░░░░░░░░██║░░░░╚═══██╗██╔══██║██║░░██║██╔═══╝░░░░░░░░
echo ░░░░░░░░░██║░░░██████╔╝██║░░██║╚█████╔╝██║░░░░░░░░░░░░
echo ░░░░░░░░░╚═╝░░░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░░░░░░░░
echo ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
echo ░░██████╗██████╗██████╗██████╗██████╗██████╗██████╗░░░
echo ░░╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝░░░
echo ░░██████╗██████╗██████╗██████╗██████╗██████╗██████╗░░░
echo ░░╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝╚═════╝░░░
echo ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
echo ░░░░░░░░░Версия приложения: %LOCAL_VERSION%░░░░░░░░░░
echo ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
exit /b


:program
title Agotik Launcher - Главная
cd %this.d%

cls
color %col1%%col2%
call :logo%logo%
echo.
echo 1. Игры
echo 2. Администрирование системы
echo 3. Дополнительный софт
echo 4. Запустить диагностику
echo 5. Справка
echo =======================================================
echo 6. Связаться со мной
echo 7. Аккаунт
echo 8. Проверить обновления
echo 9. Настройки
echo 0. Выход
choice /c 0123456789
if %errorlevel%==1 (
	exit /b
) else if %errorlevel%==2 (
	goto menu1
) else if %errorlevel%==3 (
	goto menu2
) else if %errorlevel%==4 (
	goto menu3
) else if %errorlevel%==5 (
	goto menu4
) else if %errorlevel%==6 (
	goto menu5
) else if %errorlevel%==7 (
	goto menu6
) else if %errorlevel%==8 (
	goto menu7
) else if %errorlevel%==9 (
	goto menu8
) else if %errorlevel%==10 (
	goto menu9
) else (
	goto error
)

::Игры
:menu1
title Agotik Launcher - Игры
cls
call :logo%logo%
echo 1. Roblox
echo.
echo 0. Назад
choice /c 10
if %errorlevel%==1 (
	call :games_menu Roblox menu1
) else if %errorlevel%==2 (
	goto menu
) else (
	goto error
)
goto menu1



:games_menu
set Game=%~1
set before=%~2
title Agotik Launcher - Игры - %Game%
cls
call :logo%logo%
echo 1. Установить %Game%
echo 2. Обновить %Game%
echo 3. Удалить %Game%
echo 4. Информация про %Game%
echo 5. Запустить %Game%
echo.
echo 0. Назад
choice /c 123450
if %errorlevel%==1 (
	REM msg * "inst"
	call :PrintRed "Установка игр не поддерживается в предварительной версии Agotik Launcher"
	call :games_menu %Game% %before%
) else if %errorlevel%==2 (
	msg * "Upd"
	call :games_menu %Game% %before%
) else if %errorlevel%==3 (
	msg * "del"
	call :games_menu %Game% %before%
) else if %errorlevel%==4 (
	msg * "inf"
	call :games_menu %Game% %before%
) else if %errorlevel%==5 (
	call :games_menu %Game% %before%
) else if %errorlevel%==6 (
	goto %before%
) else (
	goto error
)




::Администрирование системы
:menu2
title Agotik Launcher - Администрирование системы
cls
call :logo%logo%
echo.
echo 1. Очистка места на диске
echo 2. Починка диска (Исправление ошибок)
echo 3. Система Анти-Роскомнадзор
echo.
echo 0. Назад
choice /c 1230
if %errorlevel%==1 (
	call "%this.d%\bin\cleaner.cmd"
	goto menu2
)
if %errorlevel%==2 (
	call "%this.d%\bin\drive check.cmd"
	goto menu2
)
if %errorlevel%==3 (
	goto menu2
)
if %errorlevel%==4 (
	goto program
)
goto error






::Дополнительный софт
:menu3
title Agotik Launcher - Дополнительный софт
cls
call :logo%logo%
echo.
call :PrintRed "Функция не поддерживается в данной версии програмы"
echo.
echo 0. Назад
echo.
choice /c 0
goto program





::Диагностика
:menu4
cls
title Agotik Launcher - Диагностика
call :logo%logo%
echo Процесс диагностики запущен!
:: VPN
sc query | findstr /I "VPN" > nul
if %errorlevel%==0 (
	call :PrintRed "Найдены VPN сервисы!"
	call :PrintRed "Agotik Launcher может неправильно работать с VPN."
) else (
	call :PrintGreen "VPN сервисы не найдены!"
)
echo.

::WMIC
if not exist C:\Windows\System32\WBEM\wmic.exe (
	call :PrintRed "Утилита wmic не найдена!"
) else (
	call :PrintGreen "Утилита wmic найдена!"
)
echo.
pause
goto program









::СПРАВКА
:menu5
cls
title Agotik Launcher - Справка
call :logo%logo%
echo.
echo Выберите раздел справки:
echo.
echo 1. "Добро пожаловать!"
echo 2. "Функции приложения"
echo 3. "Настройки"
echo.
echo 0. Назад
echo.
choice /c 1230
if %errorlevel%==1 (
	start %this.d%\1.txt
) else if %errorlevel%==2 (
	start %this.d%\2.txt
) else if %errorlevel%==3 (
	start %this.d%\3.txt	
) else if %errorlevel%==4 (
	goto program
)







:menu6
cls
start "" "mailto:tshopizyt@gmail.com"
goto program







::Аккаунт
:menu7
call :PrintRed "Для этого у меня не достаточно знаний :("
pause
goto program





::Обновления
:menu8
cls
echo Проверка наличия обновлений...
set "GITHUB_VERSION_URL=https://raw.githubusercontent.com/TShoPiZyT/Agotik-Launcher/refs/heads/main/Ver/ver.txt"
set "GITHUB_DOWNLOAD_URL=https://github.com/TShoPiZyT/Agotik-Launcher/archive/refs/heads/main.zip"
chcp 866>nul
for /f "delims=" %%A in ('powershell -command "(Invoke-WebRequest -Uri \"%GITHUB_VERSION_URL%\" -Headers @{\"Cache-Control\"=\"no-cache\"} -UseBasicParsing -TimeoutSec 5).Content.Trim()" 2^>nul') do set "GITHUB_VERSION=%%A"
chcp 65001>nul
if not defined GITHUB_VERSION (
    call :PrintRed "Ошибка обновления!"
    timeout /T 9
    goto program
)
if "%LOCAL_VERSION%"=="%GITHUB_VERSION%" (
    call :PrintYellow "Последняя версия уже установлена: %LOCAL_VERSION%"
    pause
    goto program
) 
call :PrintYellow "Доступна новая версия %GITHUB_VERSION%"
echo Скачать новую версию?
choice /c YN
if %errorlevel%==1 (
    echo Открываю страницу для скачивания...
    start "" "%GITHUB_DOWNLOAD_URL%"
)
goto program






::Настройки
:menu9
title Agotik Launcher - Настройки
cls
call :logo%logo%
echo.
echo 1. Настройки Цвета
echo 2. Настройки Заголовка
echo 3. Настройки Аккаунта
echo.
echo 0. Назад
echo.
choice /c 1230
if %errorlevel%==1 (
	goto ColorsetMain
) else if %errorlevel%==2 (
	cls
	title
	mode con: cols=70 lines=40
	call :PrintRed "Error reading header with working directory"
	call :PrintRed "%this.d%:"
	echo.
	call :PrintRed "File %this.d%\bin\header.bat"
	call :PrintRed "does not exist or corrupted!"
	call :PrintYellow "New update can fix this error"
	echo.
	call :PrintYellow "Press any key to continue..."
	pause > nul
	goto menu9
) else if %errorlevel%==3 (
	goto menu7
) else if %errorlevel%==4 (
	goto program
)



:ColorsetMain
call :PrintYellow "В предварительной версии Agotik Launcher цвет меняется вручную"
call :PrintYellow "Подробнее в разделе СПРАВКА. Пункт НАСТРОЙКИ"
pause
goto menu9



::color settings fg
:colorsfg
title Agotik Launcher - Настройки Цвета
cls
call :logo%logo%
echo.
echo X._Цвет текста     Y. Цвет фона         Z. Назад
echo.
echo 0. Цвет 0          0. Цвет 0
echo 1. Цвет 1          1. Цвет 1
echo 2. Цвет 2          2. Цвет 2
echo 3. Цвет 3          3. Цвет 3
echo 4. Цвет 4          4. Цвет 4
echo 5. Цвет 5          5. Цвет 5
echo 6. Цвет 6          6. Цвет 6
echo 7. Цвет 7          7. Цвет 7
echo 8. Цвет 8          8. Цвет 8
echo 9. Цвет 9          9. Цвет 9
echo A. Цвет A          A. Цвет A
echo B. Цвет B          B. Цвет B
echo C. Цвет C          C. Цвет C
echo D. Цвет D          D. Цвет D
echo E. Цвет E          E. Цвет E
echo F. Цвет F          F. Цвет F
echo.
echo.
choice /c 1234567890XYZ
if %errorlevel% LEQ 9 (
	set "col2=%errorlevel%"
	color %col1%%col2%
) else if %errorlevel% EQU 10 (
	::color0
	set "col2=0"
	color %col1%%col2%
) else if %errorlevel% EQU 11 (
	call :PrintRed "Вы уже используете режим выбора цвета текста!"
	timeout /t 5 > nul
	goto menu9
) else if %errorlevel% EQU 12 (
	goto colorsbg
) else if %errorlevel% EQU 13 (
	goto menu9
)








::color settings bg
:colorsbg
title Agotik Launcher - Настройки Цвета
cls
call :logo%logo%
echo.
echo X. Цвет текста     Y._Цвет фона         Z. Назад
echo.
echo 0. Цвет 0          0. Цвет 0
echo 1. Цвет 1          1. Цвет 1
echo 2. Цвет 2          2. Цвет 2
echo 3. Цвет 3          3. Цвет 3
echo 4. Цвет 4          4. Цвет 4
echo 5. Цвет 5          5. Цвет 5
echo 6. Цвет 6          6. Цвет 6
echo 7. Цвет 7          7. Цвет 7
echo 8. Цвет 8          8. Цвет 8
echo 9. Цвет 9          9. Цвет 9
echo A. Цвет A          A. Цвет A
echo B. Цвет B          B. Цвет B
echo C. Цвет C          C. Цвет C
echo D. Цвет D          D. Цвет D
echo E. Цвет E          E. Цвет E
echo F. Цвет F          F. Цвет F
echo.
echo.
choice /c 1234567890XYZ
if %errorlevel% LEQ 9 (
	set "col2=%errorlevel%"
	color %col1%%col2%
) else if %erorlevel% EQU 10 (
	::color0
	set "col2=0"
	color %col1%%col2%
) else if %errorlevel% EQU 11 (
	goto colorsfg
) else if %errorlevel% EQU 12 (
	call :PrintRed "Вы уже используете режим выбора цвета текста!"
	timeout /t 5 > nul
	goto menu9
) else if %errorlevel% EQU 13 (
	goto menu9
)











:error
cd %this.d%
reg import Error.reg
start cmd /c error.bat "C:\Users\%startusername%\Desktop\Crashlog.log"
exit













:PrintGreen
chcp 866>nul
powershell -Command "Write-Host \"%~1\" -ForegroundColor Green"
chcp 866>nul
exit /b

:PrintRed
chcp 866>nul
powershell -Command "Write-Host \"%~1\" -ForegroundColor Red"
chcp 65001>nul
exit /b

:PrintYellow
chcp 866>nul
powershell -Command "Write-Host \"%~1\" -ForegroundColor Yellow"
chcp 65001>nul
exit /b
