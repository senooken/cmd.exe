:: \file      strlen.cmd
:: \author    SENOO, Ken
:: \copyright CC0
:: \brief     Count string length.
:: \sa        <https://senooken.jp/blog/2018/07/14/>

:strlen
  @echo off
  setlocal
  set str=%~1
  set len=0

  :strlen_loop
  if "%str%" neq "" (
    set str=%str:~1%
    set /a len += 1
    goto strlen_loop
  )

  echo %len%
  exit /b
