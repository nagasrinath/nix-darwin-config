{
  lib,
  wmMode,
  ...
}: let
  isTiling = wmMode == "tiling";

  stopAerospace = ''
    /usr/bin/pkill -x AeroSpace >/dev/null 2>&1 || true
    /usr/bin/osascript -e 'tell application "System Events" to if exists login item "AeroSpace" then delete login item "AeroSpace"' >/dev/null 2>&1 || true
  '';
  startAerospace = ''
    /usr/bin/pgrep -x AeroSpace >/dev/null 2>&1 || /usr/bin/open -g -a AeroSpace >/dev/null 2>&1 || true
  '';
in {
  # Reconcile the *running* state of AeroSpace with wmMode on every switch,
  # not just the declared config. Best-effort (never fails activation)
  # since AeroSpace may not be running/installed yet.
  home.activation.reconcileWmMode = lib.hm.dag.entryAfter ["writeBoundary"] (
    if isTiling
    then startAerospace
    else stopAerospace
  );
}
