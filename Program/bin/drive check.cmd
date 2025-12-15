@echo off
mode con: cols=150 lines=40
chcp 65001 >nul
setlocal EnableDelayedExpansion

call :PrintYellow "Начата операция по починке и восстановлению дисков"

for /f "skip=1 delims=" %%a in ('wmic logicaldisk get name') do (
    call :PrintYellow "Запущен процесс поиска и восстановления ошибок на диске \"%%a\""
    if /i "%%a"=="%systemdrive%" (
        call :PrintRed "Во время поиска и восстановления ошибок на диске \"%%a\" может потребоваться ваше вмешательство"
    )
    call :chkdsk %%a
    call :PrintGreen "Процесс поиска и восстановления ошибок на диске \"%%a\" завершён"
    call :PrintYellow "Запущен процесс дефрагментации диска \"%%a\""
    call :defrag %%a
    call :PrintGreen "Процесс дефрагментации диска \"%%a\" завершён"
)
:endloop

call :PrintGreen "Операция завершена"
pause
exit /b

:PrintGreen
chcp 866 >nul
powershell -Command "Write-Host '%~1' -ForegroundColor Green"
chcp 65001 >nul
exit /b


:PrintYellow
chcp 866 >nul
powershell -Command "Write-Host '%~1' -ForegroundColor Yellow"
chcp 65001 >nul
exit /b


:PrintRed
chcp 866>nul
powershell -Command "Write-Host \"%~1\" -ForegroundColor Red"
chcp 65001>nul
exit /b


:chkdsk
set disk=%~1
chcp 866 >nul
chkdsk %disk% /f /r
chcp 65001 >nul
exit /b


:defrag
set disk=%~1
chcp 866 >nul
defrag %disk% /u
chcp 65001 >nul
exit /b