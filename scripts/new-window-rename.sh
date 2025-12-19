#!/bin/bash
CTR_FILE="$HOME/.tmux/.win_counter"
n=$(($(cat "$CTR_FILE" 2>/dev/null || echo 0) + 1))
echo "$n" > "$CTR_FILE"
tmux rename-window "#$n"
