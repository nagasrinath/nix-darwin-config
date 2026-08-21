{lib, ...}: {
  # yabai runs here ONLY to strip window shadows globally; AeroSpace stays
  # the tiling engine (see home/aerospace.nix). layout float means yabai
  # never inserts or repositions windows - it just observes them and
  # bypasses the window-server shadow surface.
  #
  # Shadow stripping is core yabai (Accessibility API) and needs no SIP
  # changes. The scripting addition (--load-sa) is only required for
  # spaces/focus control; if SIP gets disabled later and SA features are
  # wanted, add:  sudo /opt/homebrew/bin/yabai --load-sa  (plus a sudoers
  # pin) - nothing here needs it.
  home.file.".config/yabai/yabairc" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh

      # Load the scripting addition (SIP partially disabled). Requires the
      # hash-pinned NOPASSWD sudoers row written by system.activationScripts
      # .yabaiSudoers in modules/system.nix.
      sudo /opt/homebrew/bin/yabai --load-sa 2>/dev/null || true
      /opt/homebrew/bin/yabai -m signal --add event=dock_did_restart \
        action="sudo /opt/homebrew/bin/yabai --load-sa 2>/dev/null || true"

      # shadow-only role: don't tile, don't move windows
      /opt/homebrew/bin/yabai -m config layout float
      /opt/homebrew/bin/yabai -m config window_shadow off

      echo "yabai configuration loaded.."
    '';
  };

  home.activation.startYabai = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # self-managed launchd agent (survives reboots); needs Accessibility
    # permission granted once on first launch
    /opt/homebrew/bin/yabai --start-service >/dev/null 2>&1 || true
  '';
}
