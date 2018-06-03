::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \file      HelpList.cmd
:: \author    SENOO, Ken
:: \copyright CC0
:: \version   1.0.4
:: \date      Created: 2018-05-22
:: \date      Updated: 2018-05-27
:: \brief     List cmd.exe standard commands help.
:: \sa        https://senooken.jp/blog/2018///

:: \details `help` has standard cmd.exe help.
:: This command file lists all `help` supported commands help (<command>.txt) to `<version>\help` directory.
:: List of commands is listed in `help.out.txt`.

:: \note Before run this file, turn UAC (User Account Control) to the lowest level or run as administrator for `diskpart`.
:: \warning `sc` help is need to enter keyboard input y|n (not stdin!) in Windows 7, 8 (Windows 10 has no problem).
:: \note These commands support only /? or without both of help and /?.
:: /? only: drivequery, openfiles, systeminfo
:: Without help and /?: sc, fsutil
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enabledelayedexpansion
pushd "%~dp0"

:: Replace `Microsoft Windows [Version x.x.xxxx]` to `x.x.xxxx`.
for /f "delims=" %%V in ('ver') do set ver=%%V
set ver=%ver:*[=%
set ver=%ver:~8,-1%
set OUTDIR=%ver%\help
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

:: Output help list.
help >"%ver%\help.out.txt"

set ALPH=ABCDEFGHIJKLMNOPQRSTUVWXYZ
for /f "delims=" %%L in ('help') do (
  rem Search help supported commands.
  echo %%L | findstr /b [%ALPH%][%ALPH%] >nul && (
    for /f %%F in ("%%L") do (set exe=%%F)

    set out=%OUTDIR%\!exe!.txt
    echo !exe!

    echo !exe!| findstr /vx "SC FSUTIL DRIVEQUERY OPENFILES SYSTEMINFO" >nul && (
      set exe=help !exe!
    ) || echo !exe!| findstr /x "DRIVEQUERY OPENFILES SYSTEMINFO" >nul && (
      set exe=!exe! /?
    ) || echo !exe!| findstr /x "SC FSUTIL" >nul && (
      if !exe! == SC if %ver:~0,2% neq 10 echo Please enter 'y'.
    )

    !exe! >"!out!"
  )
)
