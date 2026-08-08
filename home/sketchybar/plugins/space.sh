#!/bin/sh
source "$CONFIG_DIR/colors.sh"
WS="${NAME#space.}"
CURRENT="${FOCUSED_WORKSPACE:-$(@QUERY_FOCUSED_WORKSPACE_CMD@ 2>/dev/null)}"
if [ "$CURRENT" = "$WS" ]; then
  sketchybar --set $NAME background.drawing=on       \
                         background.color=0xffFFFFFF  \
                         icon.color=0xff000000
else
  sketchybar --set $NAME background.drawing=off \
                         icon.color=0x66FFFFFF
fi
