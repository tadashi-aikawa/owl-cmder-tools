set word=%~1
set command=%2 %3 %4 %5 %6 %7 %8 %9
@FOR /F "usebackq" %%t IN (`fd -t f -t l %word% -pL ^
  ^| grep -Ev "^\./(\.|vendor|node_modules)" ^
  ^| fzf`) DO %command% %%t
