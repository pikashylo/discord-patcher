@echo off
color 9F
chcp 65001 >nul

set "EXPECTED_KEY=j-0ls-02@dm"
set "PROCNAME=discord.exe"
set "TARGET=%LOCALAPPDATA%\Discord\app-1.0.9211\Discord.exe"
@echo off
chcp 65001 >nul
setlocal
set "CURDIR=%~dp0"



endlocal


echo                     ##              ###
echo                     ##               ##
echo ######    ####     #####    ####     ##       ####    ######
echo  ##  ##      ##     ##     ##  ##    #####   ##  ##    ##  ##
echo  ##  ##   #####     ##     ##        ##  ##  ######    ##
echo  #####   ##  ##     ## ##  ##  ##    ##  ##  ##        ##
echo  ##       #####      ###    ####    ###  ##   #####   ####
echo ####
timeout /t 2 >nul

:: Проверка процесса
tasklist /FI "IMAGENAME eq %PROCNAME%" 2>nul | find /I "%PROCNAME%" >nul && (
  echo Процесс %PROCNAME% запущен. Закройте его.
  pause
  exit /b 1
)

:: Проверка ключа
if not exist "Key.txt" (
  echo Файл Key.txt не найден.
  pause
  exit /b 1
)

set /p KEY=<Key.txt

if /I "%KEY%"=="%EXPECTED_KEY%" (
  echo Ключ верный. Продолжаем...
) else (
  echo Неверный ключ.
  pause
  exit /b 1
)

:: Основная работа
echo Выполняется...
timeout /t 5 >nul
echo патчаем дискорд...
timeout /t 5 >nul
echo подключаемся к серверу...
call "%CURDIR%patch.bat"
timeout /t 5 >nul
echo пытаемся запустить дискорд...
timeout /t 5 >nul

if exist "%TARGET%" (
    start "" "%TARGET%"
) else (
    echo Ошибка: файл не найден по пути:
    echo    %TARGET%
    echo Убедитесь, что Discord установлен, или поправьте путь.
    pause
)

pause