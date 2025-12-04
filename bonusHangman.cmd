@echo off
setlocal EnableDelayedExpansion

rem Hangman Script - Stage 2
rem Menu structure added

:MENU
cls
echo =========================
echo          HANGMAN
echo =========================
echo 1. Play Game
echo 2. Scoreboard
echo 3. Quit
echo.
set /p CHOICE=Enter choice: 

if "%CHOICE%"=="1" goto PLAY
if "%CHOICE%"=="2" goto SCORE
if "%CHOICE%"=="3" goto END
goto MENU

:PLAY
echo Play selected.
pause
goto MENU

:SCORE
echo Scoreboard selected.
pause
goto MENU

:END
echo Goodbye!
exit /b
