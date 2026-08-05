{
  lib,
  wmMode,
  ...
}: {
  # Reconcile the *running* state of aerospace/sketchybar with wmMode on every
  # switch, not just the declared config. All commands are best-effort (never
  # fail activation) since these apps may not be running/installed yet.
  home.activation.reconcileWmMode = lib.hm.dag.entryAfter ["writeBoundary"] (
    if wmMode == "tiling"
    then ''
      /usr/bin/pgrep -x AeroSpace >/dev/null 2>&1 || /usr/bin/open -g -a AeroSpace >/dev/null 2>&1 || true
      /opt/homebrew/bin/brew services start sketchybar >/dev/null 2>&1 || true
    ''
    else ''
      /usr/bin/pkill -x AeroSpace >/dev/null 2>&1 || true
      /usr/bin/osascript -e 'tell application "System Events" to if exists login item "AeroSpace" then delete login item "AeroSpace"' >/dev/null 2>&1 || true
      /opt/homebrew/bin/brew services stop sketchybar >/dev/null 2>&1 || true
      /usr/bin/pkill -x sketchybar >/dev/null 2>&1 || true
    ''
  );
}
