@FOR /F "usebackq" %%t IN (`git branch -l ^
  ^| grep -vE '^\*' ^
  ^| awk '{print $1}' ^
  ^| fzf`) DO git checkout %%t
