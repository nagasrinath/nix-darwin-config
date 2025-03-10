{ pkgs, ... }:
{
  system = {
    stateVersion = 6;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.IsAnalog = true;

      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
        show-recents = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        ShowStatusBar = true;
        ShowPathbar = true;
        QuitMenuItem = true;
      };

      trackpad = {
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };

      CustomUserPreferences = {
        ".GlobalPreferences" = {
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
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
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0;
          StandardHideDesktopIcons = 0;
          HideDesktop = 0;
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
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
        GuestEnabled = false;
        SHOWFULLNAME = true;
        LoginwindowText = "BE HAPPY :-)";
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = [
    pkgs.zsh pkgs.fish
  ];

  time.timeZone = "Asia/Calcutta";

  fonts = {
    packages = with pkgs; [
      nerd-fonts.inconsolata
    ];
  };
}
