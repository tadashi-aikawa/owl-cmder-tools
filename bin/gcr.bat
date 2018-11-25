@FOR /F "usebackq" %%t IN (`git branch -rl ^
  ^| grep -vE "HEAD|master" ^
  ^| awk '{print $1}' ^
  ^| sed -r 's@origin/@@g' ^
  ^| fzf`) DO git checkout -b %%t origin/%%t

