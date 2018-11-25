@echo off

if "%~1" == "" (
  set word=".*"
) else (
  set word=%~1
)

FOR /F "usebackq" %%t IN (`fd -t d -t l %word% -pL ^
  ^| grep -iE %word% ^
  ^| fzf`) DO vim %%t
