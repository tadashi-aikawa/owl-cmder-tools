@echo off

if "%~1" == "" (
  set word=".*"
) else (
  set word=%~1
)

FOR /F "tokens=* usebackq" %%t IN (`tac %cmder_root%/config/.history ^
  ^| grep -iE %word% ^
  ^| fzf --no-sort`) DO %cmder_root%\vendor\git-for-windows\usr\bin\echo.exe -n '%%t' | clip

