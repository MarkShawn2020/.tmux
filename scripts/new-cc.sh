#!/bin/bash
CTR_FILE="$HOME/.config/tmux/.win_counter"
n=$(($(cat "$CTR_FILE" 2>/dev/null || echo 0) + 1))
echo "$n" > "$CTR_FILE"

current_pane=$(tmux display -p '#{pane_id}')
current_index=$(tmux display -p '#{window_index}')
current_path=$(tmux display -p '#{pane_current_path}')
current_name=$(tmux display -p '#{window_name}')

# 1. 在当前 pane 位置创建新 pane
tmux split-window -b -c "$current_path"
# 2. 交换位置，让新 pane 在原位置
tmux swap-pane -d
# 3. 把原 pane break 到新 window（在最后）
tmux break-pane -s "$current_pane" -d
# 4. 把当前 window（新 cc + 其他 pane）重命名为 #$n
tmux rename-window "#$n"
# 5. 交换 window 位置：原 pane window 到原位置，#$n 到最后
last_index=$(tmux list-windows -F '#{window_index}' | tail -1)
tmux swap-window -s "$last_index" -t "$current_index"
# 6. 恢复原窗口名
tmux rename-window -t "$current_index" "$current_name"
# 7. 切换到 #$n
tmux select-window -t "#$n"
# 8. 运行 cc
tmux send-keys cc Enter
