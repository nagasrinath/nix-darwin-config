{
  lib,
  wmEngine,
  ...
}: let
  # Custom sketchybar event that either engine's WM-change hook triggers
  # (aerospace's exec-on-workspace-change / yabai's space_changed signal).
  workspaceChangeEvent = "${wmEngine}_workspace_change";

  # Command to switch to workspace/space $ws, used by the spaces item's
  # click_script.
  focusWorkspaceCmd =
    if wmEngine == "yabai"
    then "yabai -m space --focus"
    else "aerospace workspace";

  # Fallback command to query the currently focused workspace/space, used
  # by the spaces plugin when FOCUSED_WORKSPACE wasn't passed by the event.
  queryFocusedWorkspaceCmd =
    if wmEngine == "yabai"
    then ''yabai -m query --spaces --space | grep -o '"index":[0-9]*' | grep -o '[0-9]*' ''
    else "aerospace list-workspaces --focused";

  # Template files that embed the wmEngine-dependent commands above via
  # @PLACEHOLDER@ tokens, since home-manager's `source` only supports
  # static files.
  substitute = file:
    lib.strings.replaceStrings
    ["@WORKSPACE_CHANGE_EVENT@" "@FOCUS_WORKSPACE_CMD@" "@QUERY_FOCUSED_WORKSPACE_CMD@"]
    [workspaceChangeEvent focusWorkspaceCmd queryFocusedWorkspaceCmd]
    (builtins.readFile file);
in {
  home.activation.downloadSketchybarFont = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f "$HOME/Library/Fonts/sketchybar-app-font.ttf" ]; then
      /usr/bin/curl -L \
        "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf" \
        -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"
    fi
  '';

  home.file.".config/sketchybar/colors.sh" = {
    executable = true;
    source = ./sketchybar/colors.sh;
  };

  home.file.".config/sketchybar/sketchybarrc" = {
    executable = true;
    text = substitute ./sketchybar/sketchybarrc;
  };

  # ── items ──────────────────────────────────────────────────────────────────

  home.file.".config/sketchybar/items/spaces.sh" = {
    executable = true;
    text = substitute ./sketchybar/items/spaces.sh;
  };

  home.file.".config/sketchybar/items/front_app.sh" = {
    executable = true;
    source = ./sketchybar/items/front_app.sh;
  };

  home.file.".config/sketchybar/items/media.sh" = {
    executable = true;
    source = ./sketchybar/items/media.sh;
  };

  home.file.".config/sketchybar/items/calendar.sh" = {
    executable = true;
    source = ./sketchybar/items/calendar.sh;
  };

  home.file.".config/sketchybar/items/volume.sh" = {
    executable = true;
    source = ./sketchybar/items/volume.sh;
  };

  home.file.".config/sketchybar/items/battery.sh" = {
    executable = true;
    source = ./sketchybar/items/battery.sh;
  };

  home.file.".config/sketchybar/items/cpu.sh" = {
    executable = true;
    source = ./sketchybar/items/cpu.sh;
  };

  # ── plugins ────────────────────────────────────────────────────────────────

  home.file.".config/sketchybar/plugins/space.sh" = {
    executable = true;
    text = substitute ./sketchybar/plugins/space.sh;
  };

  home.file.".config/sketchybar/plugins/front_app.sh" = {
    executable = true;
    source = ./sketchybar/plugins/front_app.sh;
  };

  home.file.".config/sketchybar/plugins/media.sh" = {
    executable = true;
    source = ./sketchybar/plugins/media.sh;
  };

  home.file.".config/sketchybar/plugins/calendar.sh" = {
    executable = true;
    source = ./sketchybar/plugins/calendar.sh;
  };

  home.file.".config/sketchybar/plugins/volume.sh" = {
    executable = true;
    source = ./sketchybar/plugins/volume.sh;
  };

  home.file.".config/sketchybar/plugins/battery.sh" = {
    executable = true;
    source = ./sketchybar/plugins/battery.sh;
  };

  home.file.".config/sketchybar/plugins/cpu.sh" = {
    executable = true;
    source = ./sketchybar/plugins/cpu.sh;
  };

  home.file.".config/sketchybar/plugins/icon_map_fn.sh" = {
    executable = true;
    source = ./sketchybar/plugins/icon_map_fn.sh;
  };
}
