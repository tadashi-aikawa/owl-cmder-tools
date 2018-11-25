@echo off

if "%~1" == "" (
  set word=".*"
) else (
  set word=%~1
)

FOR /F "usebackq" %%t IN (`gowl list ^| grep -iE %word% ^| fzf`) DO @cd %%t
