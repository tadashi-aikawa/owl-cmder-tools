@echo off

if "%~1" == "" (
  set word=".*"
) else (
  set word=%~1
)

FOR /F "usebackq" %%t IN (`tac %home%/.cdz ^| grep -iE %word% ^| awk '!a[$0]++' ^| fzf --no-sort`) DO @cd %%t
