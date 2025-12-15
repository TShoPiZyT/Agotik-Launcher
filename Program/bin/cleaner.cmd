@echo off
mode con: cols=150 lines=40
chcp 65001>nul
call :PrintYellow "Начат этап очистки 1 из 8"
del /q /s C:\Temp\
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 1 из 8"
call :PrintYellow "Начат этап очистки 2 из 8"
del /q /s C:\Windows\Temp\
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 2 из 8"
call :PrintYellow "Начат этап очистки 3 из 8"
del /q /s C:\Windows\SystemTemp\
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 3 из 8"
call :PrintYellow "Начат этап очистки 4 из 8"
del /q /s "%userprofile%\AppData\Local\Temp"
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 4 из 8"
call :PrintYellow "Начат этап очистки 5 из 8"
del /q /s "%userprofile%\AppData\LocalLow\Intel\ShaderCache"
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 5 из 8"
call :PrintYellow "Начат этап очистки 6 из 8"
del /q /s C:\*.tmp
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 6 из 8"
call :PrintYellow "Начат этап очистки 7 из 8"
del /q /s C:\*.log
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 7 из 8"
call :PrintYellow "Начат этап очистки 8 из 8"
del /q /s C:\Windows\SoftwareDistribution\Download
echo.
echo.
echo.
echo.
echo.
call :PrintYellow "Окончен этап очистки 8 из 8"
timeout /t 3 /nobreak > nul
cls
call :PrintGreen "Очистка завершена"
call :PrintYellow "Возвращаюсь обратно..."
timeout /t 7 /nobreak > nul
exit /b






:PrintGreen
chcp 866>nul
powershell -Command "Write-Host \"%~1\" -ForegroundColor Green"
chcp 65001>nul
exit /b

:PrintYellow
chcp 866>nul
powershell -Command "Write-Host \"%~1\" -ForegroundColor Yellow"
chcp 65001>nul
exit /b