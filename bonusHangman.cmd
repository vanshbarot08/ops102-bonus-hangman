@echo off
setlocal EnableDelayedExpansion

rem Hangman Script - Stage 2
rem Menu structure added
rem Word list added in stage 3
set WORD1=computer
set WORD2=program
set WORD3=script
set WORD4=matrix
set WORD5=coding
set WORD6=canada
set WORD7=seneca
set WORD8=hangman

set TOTAL=8


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
cls

set /a INDEX=%RANDOM% %% %TOTAL% + 1
set SECRET=!WORD%INDEX%!

rem Build mask of underscores
set MASK=
for /l %%i in (0,1,30) do (
    set C=!SECRET:~%%i,1!
    if not "!C!"=="" (
        set MASK=!MASK!_
    )
)

echo Word mask created: %MASK%
pause
goto MENU



:SCORE
echo Scoreboard selected.
pause
goto MENU

:END
echo Goodbye!
exit /b
