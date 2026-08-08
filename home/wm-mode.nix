{
  lib,
  wmMode,
  wmEngine,
  ...
}: let
  isTiling = wmMode == "tiling";
  isAerospace = isTiling && wmEngine == "aerospace";
  isYabai = isTiling && wmEngine == "yabai";

  stopAerospace = ''
    /usr/bin/pkill -x AeroSpace >/dev/null 2>&1 || true
    /usr/bin/osascript -e 'tell application "System Events" to if exists login item "AeroSpace" then delete login item "AeroSpace"' >/dev/null 2>&1 || true
  '';
  startAerospace = ''
    /usr/bin/pgrep -x AeroSpace >/dev/null 2>&1 || /usr/bin/open -g -a AeroSpace >/dev/null 2>&1 || true
  '';

  # ponytail: the asmvik/formulae yabai/skhd formulas don't implement
  # `brew services` (no plist/service block) - they self-manage launchd
  # via --start-service/--stop-service instead.
  stopYabai = ''
    /opt/homebrew/bin/yabai --stop-service >/dev/null 2>&1 || true
    /opt/homebrew/bin/skhd --stop-service >/dev/null 2>&1 || true
    /usr/bin/pkill -x yabai >/dev/null 2>&1 || true
    /usr/bin/pkill -x skhd >/dev/null 2>&1 || true
  '';
  startYabai = ''
    /opt/homebrew/bin/yabai --start-service >/dev/null 2>&1 || true
    /opt/homebrew/bin/skhd --start-service >/dev/null 2>&1 || true
  '';

  stopSketchybar = ''
    /opt/homebrew/bin/brew services stop sketchybar >/dev/null 2>&1 || true
    /usr/bin/pkill -x sketchybar >/dev/null 2>&1 || true
  '';
  startSketchybar = ''
    /opt/homebrew/bin/brew services start sketchybar >/dev/null 2>&1 || true
  '';
in {
  # Reconcile the *running* state of the tiling WM (aerospace/yabai+skhd) and
  # sketchybar with wmMode/wmEngine on every switch, not just the declared
  # config. All commands are best-effort (never fail activation) since these
  # apps may not be running/installed yet.
  home.activation.reconcileWmMode = lib.hm.dag.entryAfter ["writeBoundary"] (
    lib.concatStrings [
      (
        if isAerospace
        then startAerospace
        else stopAerospace
      )
      (
        if isYabai
        then startYabai
        else stopYabai
      )
      (
        if isTiling
        then startSketchybar
        else stopSketchybar
      )
    ]
  );
}
