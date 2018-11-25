@echo off

if "%~1" == "" (
  set word=".*"
) else (
  set word=%~1
)

FOR /F "usebackq" %%t IN (`gowl list ^| grep -iE %word% ^| fzf --select-1`) DO @cd %%t
