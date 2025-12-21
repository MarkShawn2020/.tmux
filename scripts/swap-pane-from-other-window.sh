#!/bin/bash
# swap-pane-from-other-window.sh
# Shift+Alt+F6: 用上一个 window 的活动 pane 替换当前 pane

current_pane=$(tmux display -p '#{pane_id}')

# 获取上一个 window 的活动 pane
last_pane=$(tmux display -p -t ':{last}' '#{pane_id}' 2>/dev/null)

if [ -z "$last_pane" ]; then
    tmux display-message "Error: No last window found"
    exit 1
fi

# 执行替换：把 last_pane 移到 current_pane 位置，然后 kill current_pane
tmux join-pane -s "$last_pane" -t "$current_pane"
tmux kill-pane -t "$current_pane"
