{
  lib,
  wmMode,
  wmEngine,
  ...
}: let
  isTiling = wmMode == "tiling";
  isRift = isTiling && wmEngine == "rift";

  stopAerospace = ''
    /usr/bin/pkill -x AeroSpace >/dev/null 2>&1 || true
    /usr/bin/osascript -e 'tell application "System Events" to if exists login item "AeroSpace" then delete login item "AeroSpace"' >/dev/null 2>&1 || true
  '';
  startAerospace = ''
    /usr/bin/pgrep -x AeroSpace >/dev/null 2>&1 || /usr/bin/open -g -a AeroSpace >/dev/null 2>&1 || true
  '';

  # rift self-manages a launchd service (service commands live in the
  # rift binary, not rift-cli); engines are mutually exclusive (both grab
  # global window events), so each branch also stops the other engine
  stopRift = ''
    /opt/homebrew/bin/rift service stop >/dev/null 2>&1 || true
    /usr/bin/pkill -x rift >/dev/null 2>&1 || true
  '';
  startRift = ''
    if [ -x /opt/homebrew/bin/rift ]; then
      /opt/homebrew/bin/rift service install >/dev/null 2>&1 || true
      /opt/homebrew/bin/rift service start >/dev/null 2>&1 || true
    fi
  '';
in {
  # Reconcile the *running* state of the WM with wmMode/wmEngine on every
  # switch, not just the declared config. Best-effort (never fails
  # activation) since the engines may not be running/installed yet.
  home.activation.reconcileWmMode = lib.hm.dag.entryAfter ["writeBoundary"] (
    lib.concatStrings [
      (
        if isTiling && !isRift
        then startAerospace
        else stopAerospace
      )
      (
        if isRift
        then startRift
        else stopRift
      )
    ]
  );
}
