@echo off
setlocal EnableDelayedExpansion

rem Stage 6 - Add colour support
for /f "delims=" %%A in ('echo prompt $E^| cmd') do set "ESC=%%A"

set RED=%ESC%[91m
set GREEN=%ESC%[92m
set YELLOW=%ESC%[93m
set CYAN=%ESC%[96m
set RESET=%ESC%[0m


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
echo %CYAN%===================================%RESET%
echo %CYAN%                HANGMAN         %RESET%
echo %CYAN%===================================%RESET%
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

set MASK=
for /l %%i in (0,1,30) do (
    set C=!SECRET:~%%i,1!
    if not "!C!"=="" set MASK=!MASK!_
)

set GUESSES=
set WRONG=0
set MAXWRONG=6

:ROUND
cls
echo %CYAN%=========================%RESET%
echo Word: %YELLOW%%MASK%%RESET%
echo Wrong guesses: %RED%%WRONG%%RESET% / %MAXWRONG%
echo Guessed letters: %GUESSES%
echo %CYAN%=========================%RESET%
echo.

if "%MASK%"=="%SECRET%" goto WIN
if %WRONG% GEQ %MAXWRONG% goto LOSE

set /p LETTER=Enter a letter: 
set LETTER=%LETTER:~0,1%

if "%LETTER%"=="" goto ROUND

echo %GUESSES% | find /i " %LETTER% " >nul
if %errorlevel%==0 (
    echo Already guessed.
    pause
    goto ROUND
)

set GUESSES=%GUESSES% %LETTER%

echo %SECRET% | find /i "%LETTER%" >nul
if %errorlevel%==0 (
    set NEW=
    for /l %%i in (0,1,30) do (
        set C=!SECRET:~%%i,1!
        set M=!MASK:~%%i,1!

        if "!C!"=="" (
        ) else (
            if /i "!C!"=="%LETTER%" (
                set NEW=!NEW!!LETTER!
            ) else (
                set NEW=!NEW!!M!
            )
        )
    )
    set MASK=!NEW!
) else (
    set /a WRONG+=1
)

goto ROUND

:WIN
echo %GREEN%You guessed it!%RESET%
echo Word was: %GREEN%%SECRET%%RESET%
set /a WINS+=1
set /a GAMES+=1
pause
goto MENU

:LOSE
echo %RED%You lost!%RESET%
echo Word was: %RED%%SECRET%%RESET%
set /a GAMES+=1
pause
goto MENU



:SCORE
cls
echo %CYAN%===================================%RESET%
echo %CYAN%               SCOREBOARD       %RESET%
echo %CYAN%===================================%RESET%
echo Games Played: %GAMES%
echo Games Won:    %WINS%
pause
goto MENU


:END
echo Goodbye!
echo Thanks for Playing.
exit /b
