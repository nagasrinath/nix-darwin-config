# nix

Personal macOS system configuration using [nix-darwin](https://github.com/lnl7/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager), managed as a flake.

![screenshot](screenshots/screenshot1.png)
![screenshot](screenshots/screenshot2.png)

## Usage

```sh
darwin-rebuild switch --flake ~/.config/nix
```

(aliased to `dr` in fish, see `home/shell.nix`)

## Structure

```
flake.nix          entry point (inputs, username/hostname, wmMode/wmEngine,
                   darwinConfiguration)
modules/           system-level (nix-darwin) config
  nix-core.nix        nix settings (flakes, gc, auto-optimise)
  system.nix          macOS defaults & tweaks
  apps.nix            homebrew (casks/brews/mas apps)
  fonts.nix           custom font derivations
  host-users.nix      hostname + user account
home/              user-level (home-manager) config, one file per tool
  <tool>.nix          wires up home.file/home.activation for <tool>
  <tool>/             the actual config files <tool>.nix deploys (dotfiles,
                       scripts, patches) - kept out of the .nix so they read
                       and diff like normal config, not embedded strings
```

`wmMode` and `wmEngine`, set at the top of `flake.nix`, gate most of the window-management-related config (see [Window management](#window-management)).

## macOS tweaks applied

All set declaratively in `modules/system.nix`:

- **Trackpad**: tap to click off, three-finger drag on, three-finger swipe between pages kept on, vertical/four-finger swipes off; pinch gestures (Mission Control / App Exposé / Launchpad & Show Desktop) on in normal mode, off in tiling mode (the WM replaces them)
- **Keyboard**: fast key repeat, no auto-capitalize/dash/period/quote substitution, no autocorrect
- **Windows**: no window animations, drag windows with ctrl+cmd (anywhere in the window); title-bar double-click and macOS window tiling (edge drag / opt-drag) on in normal mode, disabled in tiling mode; tiled margins always off; dragging to top of screen triggers Mission Control only in normal mode
- **Display**: built-in display pinned to "More Space" scaling via `displayplacer` (activation script)
- **Dock**: auto-hide, bottom, no rearranging by most-recently-used; instant reveal in normal mode, effectively never shows in tiling mode (huge delay)
- **Menu bar**: analog clock, hidden in fullscreen
- **Finder**: show all file extensions, path bar + status bar, column view by default, Quit menu item, show external/USB/network drives on desktop
- **Desktop**: icons hidden (Stage Manager style)
- **Screenshots**: saved as PNG to `~/Pictures/Screenshots`
- **Screensaver**: require password immediately on wake
- **Touch ID for sudo** enabled
- **Light mode**, silent system sounds, no Apple ad personalization
- Default shells: fish (login) and zsh, both registered system-wide

## Apps (Homebrew, declared in `modules/apps.nix`)

- **Browsers**: Brave, Firefox, Chrome, Helium, Tor, Dia
- **Development**: VS Code, Cursor, Zed, Obsidian, JetBrains Toolbox, OrbStack, Postman, Sequel Ace, TablePlus, Yaak, Supacode, Amp, opencode (via `anomalyco/tap`), Claude (desktop) & Claude Code, Codex, Copilot CLI
- **Communication**: Discord, Telegram, Signal, nchat (via `d99kris/nchat`)
- **Productivity & utilities**: 1Password (+ CLI), ChatGPT, Blip, Free Download Manager, Tailscale, Gloomberb, Itsycal, Wispr Flow, AnyDesk
- **Media & design**: Figma, GIMP, IINA, OBS, Spotify
- **System & other**: AeroSpace (tiling WM), Ghostty, Nerd Fonts, Transmission, UTM, Steam, Xonotic
- **Mac App Store**: WhatsApp, WireGuard, Windows App, Xcode
- **CLI (brew)**: node/npm, ruby, rust, scrcpy, openvpn, container, postgrest, fabric-ai, herdr, happy-coder, jcode, git-filter-repo, mas, trash, mole, mdv, polygraph (full list in `modules/apps.nix`)

Homebrew's `openjdk` formula is keg-only, so `modules/system.nix` symlinks it into `/Library/Java/JavaVirtualMachines` via an activation script so `/usr/libexec/java_home` and GUI apps can find it.

## Terminal / shell

- Shell: [fish](home/shell.nix) with [starship](home/starship.nix) prompt, Homebrew on PATH
- Terminal: [Ghostty](home/ghostty.nix) — Tokyo Night, ComicShannsMono Nerd Font Mono, no "Last login" banner (`~/.hushlogin`)
- CLI tools ([home/core.nix](home/core.nix)): ripgrep, fzf, eza, zoxide, bat (Tokyo Night theme), yazi, zellij (Tokyo Night, minimal), skim, jq, gh, htop, fastfetch, atuin (Tokyo Night theme), ollama, tokei, ffmpeg, and language servers/toolchains for Go, Rust, Python, Node + Bun, Lua, Java

## Editors

- [Helix](home/helix.nix) — primary editor, Tokyo Night theme (transparent background), LSPs for Nix/Go/Python/Lua/TS/Java
- [Neovim](home/neovim.nix) — NvChad-based config, Tokyo Night theme (transparent), set as `$EDITOR`
- [Zed](home/zed.nix)

## Window management

Two knobs at the top of `flake.nix` control the desktop:

- `wmMode` — `"tiling"` or `"normal"`. Tiling runs a WM engine, hides the dock (long delay) and menu bar; normal restores stock macOS (instant dock, pinch gestures and macOS window tiling back). `home/wm-mode.nix` reconciles the *running* state to match on every activation — starts/stops the engine, manages the login item / launchd service, and makes sure the two mutually-exclusive engines never run at once.
- `wmEngine` — which tiling engine to use when `wmMode == "tiling"`:
  - [AeroSpace](home/aerospace.nix) — vim-style keybindings (`alt+hjkl`), `alt+enter` opens a new Ghostty window, no private APIs (config: `home/aerospace/aerospace.toml`)
  - [Rift](home/rift.nix) — private-API Rust WM trial, full binding parity with AeroSpace (config: `home/rift/config.toml`)

AeroSpace is only deployed when `wmMode == "tiling"` (see `home/default.nix`); the rift config is only deployed when `wmEngine == "rift"`, so the two configs never fight over keybindings.

## Git

Configured in [home/git.nix](home/git.nix): `main` as default branch, autosetup remote on push, rebase on pull, short aliases (`gs`, `ga`, `gc`, `gp`, `gl`, ...). Commits are SSH-signed with a key stored in 1Password (`op-ssh-sign`).
