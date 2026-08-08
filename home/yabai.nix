{
  lib,
  pkgs,
  ...
}: let
  # ponytail: yabai's upstream release doesn't support this macOS beta yet
  # (space-focus is silently broken - see asmvik/yabai#2802). This builds a
  # local patch from a pinned commit + macos27.patch, cached by commit hash
  # so the binary is byte-identical across rebuilds (Mach-O embeds a random
  # UUID per compile, so re-signing on every rebuild would keep invalidating
  # the sudoers hash pin below). Homebrew reinstalls the vanilla binary on
  # every switch; this activation script runs after it and overwrites it
  # back with the patched one.
  #
  # Requires a one-time-per-machine "yabai-cert" Code Signing identity in
  # the login keychain (self-signed, trusted for codeSign) - this script
  # only uses it, never creates/trusts it. Upgrade path: bump patchCommit
  # below to track a newer upstream fix, or drop this whole file once
  # asmvik/yabai officially supports this macOS version.
  patchCommit = "dd845723416f5fe92af49fad5ebab00369e07edd";
  patchFile = ./yabai/macos27.patch;
in {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    source = ./yabai/yabairc;
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    source = ./yabai/skhdrc;
  };

  home.activation.buildPatchedYabai = lib.hm.dag.entryAfter ["writeBoundary"] ''
    cache="$HOME/.cache/yabai-macos27-patch/${patchCommit}/yabai"
    dst="/opt/homebrew/bin/yabai"

    if [ ! -x "$cache" ]; then
      echo "yabai: building macOS 27 scripting-addition patch (one-time, needs local 'yabai-cert')..."
      build="$(/usr/bin/mktemp -d)"
      if ${pkgs.git}/bin/git clone --quiet https://github.com/asmvik/yabai.git "$build" \
        && (cd "$build" \
            && ${pkgs.git}/bin/git checkout --quiet ${patchCommit} \
            && ${pkgs.git}/bin/git apply ${patchFile} \
            && PATH="/usr/bin:$PATH" /usr/bin/make install >/dev/null \
            && PATH="/usr/bin:$PATH" /usr/bin/make sign); then
        /bin/mkdir -p "$(/usr/bin/dirname "$cache")"
        /bin/cp "$build/bin/yabai" "$cache"
      else
        echo "yabai: macOS 27 patch build failed, leaving Homebrew's yabai in place" >&2
      fi
      /bin/rm -rf "$build"
    fi

    if [ -x "$cache" ] && ! /usr/bin/cmp -s "$cache" "$dst" 2>/dev/null; then
      /bin/rm -f "$dst"
      /bin/cp "$cache" "$dst"
      echo "yabai: installed macOS 27 scripting-addition patch at $dst"
      echo "  if this is a new build (first run, or patchCommit changed), reload the SA:"
      echo "    sudo $dst --uninstall-sa && sudo $dst --load-sa && sudo $dst --load-sa"
      echo "  and refresh the sudoers hash pin + Accessibility grant if needed."
    fi
  '';
}
