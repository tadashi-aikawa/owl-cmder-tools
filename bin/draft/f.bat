@FOR /F "usebackq" %%t IN (`fd -t f -t l -pL ^
  ^| grep -Ev "^\./(\.|vendor|node_modules)" ^
  ^| fzf`) DO %* %%t
