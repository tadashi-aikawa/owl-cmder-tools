@FOR /F "usebackq" %%t IN (`ls ^| fzf --multi`) DO @cd %%t && echo [%%t] && git fetch --all --prune -q && git rev-list --count --left-right @{upstream}...HEAD | awk '{print " «"$1" ª"$2}' && cd ..
