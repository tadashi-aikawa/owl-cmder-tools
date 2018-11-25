@FOR /F "usebackq" %%t IN (`fd -t d -pL ^
  ^| grep -Ev "^(\.|vendor|node_modules)" ^
  ^| fzf`) DO %* %%t
