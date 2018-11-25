@echo off

if "%~1" == "" (
  set word=".*"
) else (
  set word=%~1
)

FOR /F "usebackq" %%t IN (`fd -t d -pL ^
  ^| grep -iE %word% ^
  ^| fzf`) DO cd %%t
