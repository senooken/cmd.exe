::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \file      helplist.cmd
:: \author    SENOO, Ken
:: \copyright CC0
:: \version   1.0.2
:: \date      Created: 2018-05-22
:: \date      Updated: 2018-05-23
:: \brief     List cmd.exe standard commands help.
:: \sa        https://senooken.jp/blog/2018///

:: \details `help` has standard cmd.exe help.
:: This command file lists all `help` supported commands help (<command>.txt) to `<version>\help` directory.
:: List of commands is listed in `help.out.txt`.

:: \note Before run this file, turn UAC (User Account Control) to the lowest level or run as administrator for `diskpart`.
:: \warning `sc` help is need to enter keyboard input y|n (not stdin!) in Windows 7 (Windows 10 has no problem).
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enabledelayedexpansion
cd "%~p0"

:: Replace `Microsoft Windows [Version x.x.xxxx]` to `x.x.xxxx`.
for /f "delims=" %%V in ('ver') do set ver=%%V
set ver=%ver:*[=%
set ver=%ver:~8,-1%
set OUTDIR=%ver%\help
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

:: Output help list.
help >"%ver%\help.out.txt"

for /f "delims=" %%L in ('help') do (
  rem Search help supported commands.
  echo %%L | findstr "^[A-Z][A-Z]" >nul && (
    for /f %%F in ("%%L") do (set exe=%%F)
    set out=%OUTDIR%\!exe!.txt
    echo !out!
    if "!exe!" == "SC" (
      echo Please enter 'y'.
      echo y | !exe! >"!out!"
    ) else (
      help !exe! >"!out!"
    )
  )
)
