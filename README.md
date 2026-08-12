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
flake.nix          entry point (inputs, username/hostname, wmMode, darwinConfiguration)
modules/           system-level (nix-darwin) config
  nix-core.nix        nix settings (flakes, gc, auto-optimise)
  system.nix          macOS defaults & tweaks
  apps.nix            homebrew (casks/brews/mas apps)
  fonts.nix           custom font derivations
  host-users.nix      hostname + user account
home/               user-level (home-manager) config, one file per tool
  <tool>.nix          wires up home.file/home.activation for <tool>
  <tool>/             the actual config files <tool>.nix deploys (dotfiles,
                       scripts, patches) - kept out of the .nix so they read
                       and diff like normal config, not embedded strings
```

`wmMode`, set at the top of `flake.nix`, gates most of the window-management-related config: `"tiling"` (AeroSpace enabled, dock/menu bar hidden) or `"normal"` (stock macOS dock/menu bar, nothing tiling-related runs). `home/wm-mode.nix` reconciles the actual running processes to match it on every activation.

## macOS tweaks applied

All set declaratively in `modules/system.nix`:

- **Trackpad**: tap to click off, three-finger drag on, three-finger swipe for app switching
- **Keyboard**: fast key repeat, no auto-capitalize/dash/period/quote substitution, no autocorrect
- **Dock**: auto-hide (no delay), bottom, no rearranging by most-recently-used
- **Menu bar**: auto-hidden, analog clock
- **Finder**: show all file extensions, path bar + status bar, list view by default, show external/USB/network drives on desktop
- **Desktop**: icons hidden (Stage Manager style)
- **Screenshots**: saved as PNG to `~/Pictures/Screenshots`
- **Screensaver**: require password immediately on wake
- **Touch ID for sudo** enabled
- **Dark mode**, silent system sounds, no Apple ad personalization
- Default shells: fish (login) and zsh, both registered system-wide

## Apps (Homebrew, declared in `modules/apps.nix`)

- **Browsers**: Brave, Firefox (+ Nightly), Chrome, Helium, Tor, Zen, Dia
- **Development**: Cursor, VS Code, Zed, Obsidian, JetBrains Toolbox, OrbStack, Postman, Sequel Ace, Claude / Claude Code, Supacode
- **Communication**: Superhuman, Discord, Microsoft Teams, Telegram, Signal
- **Productivity & utilities**: 1Password (+ CLI), Raycast, ChatGPT, Tailscale, NordVPN, Obscura VPN
- **Media & design**: GIMP, IINA, OBS, Spotify
- **System & other**: Karabiner Elements, AeroSpace (tiling WM), Ghostty/Kitty/Alacritty, Nerd Fonts, Transmission, UTM, AnyDesk
- **Mac App Store**: WhatsApp, Bear, WireGuard, Windows App

## Terminal / shell

- Shell: [fish](home/shell.nix) with [starship](home/starship.nix) prompt
- Terminals: [Ghostty](home/ghostty.nix), [Kitty](home/kitty.nix) & [Alacritty](home/alacritty.nix) — Nord, IoskeleyMono Nerd Font
- CLI tools ([home/core.nix](home/core.nix)): ripgrep, fzf, eza, zoxide, bat, yazi, jq, gh, htop, fastfetch, and language servers/toolchains for Go, Python, Node, Lua, Java

## Editors

- [Helix](home/helix.nix) — primary editor, Nord theme, LSPs for Nix/Go/Python/Lua/TS/Java
- [Neovim](home/neovim.nix) — NvChad-based config, set as `$EDITOR`

## Window management

- [AeroSpace](home/aerospace.nix) — the tiling window manager, vim-style keybindings (`alt+hjkl`) defined in its own config, no private APIs

Only runs when `wmMode == "tiling"`.

## Git

Configured in [home/git.nix](home/git.nix): `main` as default branch, autosetup remote on push, rebase on pull, short aliases (`gs`, `ga`, `gc`, `gp`, `gl`, ...).
