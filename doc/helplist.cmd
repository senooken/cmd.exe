::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \file      helplist.cmd
:: \author    SENOO, Ken
:: \copyright CC0
:: \brief     List cmd.exe standard commands help.
:: \sa        https://senooken.jp/blog/2018///

:: \details `help` has standard cmd.exe help.
:: This command file lists all `help` supported commands help (<command>.txt) to `[Windows version]\help` directory ([Microsoft Windows ...]).
:: List of commands is listed in `help.out.txt`.

:: \note Before run this file, turn UAC (User Account Control) to the lowest level or run as administrator for `diskpart`.
:: \warn `sc` help is need to enter keyboard input y|n (not stdin!) in Windows 7 (Windows 10 has no problem).
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enabledelayedexpansion
cd "%~p0"

for /f "delims=" %%V in ('ver') do set VER=%%V
set OUTDIR=%VER%\help
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

rem Output help list.
help >"%OUTDIR%\help.out.txt"

for /f "delims=" %%L in ('help') do (
  rem Search help supported commands.
  echo %%L | findstr "^[A-Z]" >nul
  if not errorlevel 1 (
    for /f %%F in ("%%L") do (set exe=%%F)
    set out=%OUTDIR%\!exe!.txt
    echo !out!
    if "%%F" == "SC" (
      echo Please enter 'y'.
      echo y | !exe! >"!out!"
    ) else (
      help !exe! >"!out!"
    )
  )
)
