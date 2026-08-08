#!/bin/bash
WORKSPACES=(1 2 3 4 5)
for ws in "${WORKSPACES[@]}"; do
  sketchybar --add item space.$ws left \
             --set space.$ws icon="$ws"                               \
                             label.drawing=off                        \
                             icon.padding_left=8                      \
                             icon.padding_right=8                     \
                             padding_left=2                           \
                             padding_right=2                          \
                             click_script="@FOCUS_WORKSPACE_CMD@ $ws" \
                             script="$PLUGIN_DIR/space.sh"            \
             --subscribe space.$ws @WORKSPACE_CHANGE_EVENT@
done
