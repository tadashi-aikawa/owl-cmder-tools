@FOR /F "usebackq" %%t IN (`git branch -l ^
  ^| grep -vE '^\*' ^
  ^| tr -d " " ^
  ^| fzf`) DO git merge --no-ff %%t
