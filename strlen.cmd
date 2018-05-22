::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \file      strlen.cmd
:: \author    SENOO, Ken
:: \copyright CC0
:: \brief     Count string length.
:: \sa        https://senooken.jp/blog//
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:strlen
  @echo off
  setlocal
  set str=%~1
  set len=0

  :strlen_loop
    if "%str%" == "" (
      echo %len%
      exit /b
    )

    set str=%str:~1%
    set /a len = len + 1
  goto :strlen_loop
