{
  pkgs,
  username,
  wmMode,
  ...
}: let
  isTiling = wmMode == "tiling";
in {
  system = {
    stateVersion = 6;
    primaryUser = username;
    activationScripts.displayScale.text = ''
      /opt/homebrew/bin/displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1710x1112 hz:60 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" >/dev/null 2>&1 || true
    '';

    defaults = {
      menuExtraClock.IsAnalog = true;

      dock = {
        # always autohide; tiling mode additionally sets a very long
        # show-delay below (effectively disabling reveal-on-hover)
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        ShowStatusBar = true;
        ShowPathbar = true;
        QuitMenuItem = true;
      };

      trackpad = {
        Clicking = false;
        TrackpadThreeFingerDrag = true;
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 15, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        # menu bar auto-hide: "In Full Screen Only"
        # (see https://developer.apple.com/documentation/devicemanagement/globalpreferences)
        _HIHideMenuBar = false;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowShouldDragOnGesture = true;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      CustomUserPreferences = {
        ".GlobalPreferences" = {
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          AppleMenuBarVisibleInFullscreen = false;
          AppleActionOnDoubleClick = "None";
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0;
        };

        # tiling window manager replaces macOS trackpad gestures;
        # keep three-finger horizontal swipe (swipe between pages)
        "com.apple.AppleMultitouchTrackpad" = {
          TrackpadThreeFingerHorizSwipeGesture = 1;
          TrackpadThreeFingerVertSwipeGesture = 0;
          TrackpadFourFingerHorizSwipeGesture = 0;
          TrackpadFourFingerVertSwipeGesture = 0;
          TrackpadPinch = 0;
          TrackpadFourFingerPinchGesture = 0;
          TrackpadFiveFingerPinchGesture = 0;
        };
        "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
          TrackpadThreeFingerHorizSwipeGesture = 1;
          TrackpadThreeFingerVertSwipeGesture = 0;
          TrackpadFourFingerHorizSwipeGesture = 0;
          TrackpadFourFingerVertSwipeGesture = 0;
          TrackpadPinch = 0;
          TrackpadFourFingerPinchGesture = 0;
          TrackpadFiveFingerPinchGesture = 0;
        };
        "com.apple.dock" = {
          # tiling: ~16.6 minutes, i.e. never shows in practice; normal: stock delay
          autohide-delay =
            if isTiling
            then 1000.0
            else 0.5;

          # tiling window manager replaces these trackpad gestures
          showDesktopGestureEnabled = false;
          showMissionControlGestureEnabled = false;

          # dragging a window to the top must not trigger Mission Control
          enterMissionControlByTopWindowDrag = false;
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0;
          StandardHideDesktopIcons = 1;
          HideDesktop = 1;
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;

          # AeroSpace handles tiling; disable macOS window tiling
          EnableTilingByEdgeDrag = 0;
          EnableTopTilingByEdgeDrag = 0;
          EnableTilingOptionAccelerator = 0;
          EnableTiledWindowMargins = 0;
        };
        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Pictures/Screenshots";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.ImageCapture".disableHotPlug = true;
      };

      loginwindow = {
        # GuestEnabled = false;
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = [
    pkgs.zsh
    pkgs.fish
  ];

  time.timeZone = "Asia/Calcutta";

  fonts = {
    packages = with pkgs; [
      nerd-fonts.inconsolata
      nerd-fonts.comic-shanns-mono
      nerd-fonts.jetbrains-mono
      departure-mono
    ];
  };
}
