{lib, ...}: {
  home.activation.downloadSketchybarFont = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f "$HOME/Library/Fonts/sketchybar-app-font.ttf" ]; then
      /usr/bin/curl -L \
        "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf" \
        -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"
    fi
  '';

  home.file.".config/sketchybar/colors.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      export WHITE=0xffFFFFFF
      export BAR_COLOR=0x00000000
      export ITEM_BG_COLOR=0x55000000
      export ACCENT_COLOR=0xffFFFFFF
      export TEXT_COLOR=0xff000000
    '';
  };

  home.file.".config/sketchybar/sketchybarrc" = {
    executable = true;
    text = ''
      #!/bin/bash
      source "$CONFIG_DIR/colors.sh"

      PLUGIN_DIR="$CONFIG_DIR/plugins"
      ITEM_DIR="$CONFIG_DIR/items"

      sketchybar --bar height=34        \
                       blur_radius=80  \
                       position=top    \
                       sticky=off      \
                       padding_left=10 \
                       padding_right=10 \
                       color=$BAR_COLOR

      sketchybar --default icon.font="SF Pro:Semibold:14.0"  \
                           icon.color=$WHITE                  \
                           label.font="SF Pro:Semibold:14.0"  \
                           label.color=$WHITE                 \
                           background.drawing=on               \
                           background.color=$ITEM_BG_COLOR    \
                           background.corner_radius=8         \
                           background.height=24               \
                           padding_left=8                     \
                           padding_right=8                    \
                           label.padding_left=4               \
                           label.padding_right=10             \
                           icon.padding_left=10               \
                           icon.padding_right=4

      sketchybar --add event aerospace_workspace_change

      source $ITEM_DIR/spaces.sh
      source $ITEM_DIR/front_app.sh
      source $ITEM_DIR/media.sh
      source $ITEM_DIR/calendar.sh
      source $ITEM_DIR/volume.sh
      source $ITEM_DIR/battery.sh
      source $ITEM_DIR/cpu.sh

      sketchybar --update
    '';
  };

  # ── items ──────────────────────────────────────────────────────────────────

  home.file.".config/sketchybar/items/spaces.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      WORKSPACES=(1 2 3 4 5)
      for ws in "''${WORKSPACES[@]}"; do
        sketchybar --add item space.$ws left \
                   --set space.$ws icon="$ws"                               \
                                   label.drawing=off                        \
                                   icon.padding_left=8                      \
                                   icon.padding_right=8                     \
                                   padding_left=2                           \
                                   padding_right=2                          \
                                   click_script="aerospace workspace $ws"   \
                                   script="$PLUGIN_DIR/space.sh"            \
                   --subscribe space.$ws aerospace_workspace_change
      done
    '';
  };

  home.file.".config/sketchybar/items/front_app.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --add item front_app left \
                 --set front_app background.color=$ITEM_BG_COLOR           \
                                 background.corner_radius=8                \
                                 icon.color=$WHITE                         \
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 label.color=$WHITE                        \
                                 label="Finder"                            \
                                 script="$PLUGIN_DIR/front_app.sh"        \
                 --subscribe front_app front_app_switched
    '';
  };

  home.file.".config/sketchybar/items/media.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --add item media e \
                 --set media label.color=$ACCENT_COLOR  \
                             label.max_chars=20          \
                             icon.padding_left=0         \
                             scroll_texts=on             \
                             icon=􀑪                      \
                             icon.color=$ACCENT_COLOR    \
                             background.drawing=off      \
                             script="$PLUGIN_DIR/media.sh" \
                 --subscribe media media_change
    '';
  };

  home.file.".config/sketchybar/items/calendar.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --add item calendar right \
                 --set calendar icon=􀧞         \
                                update_freq=30  \
                                script="$PLUGIN_DIR/calendar.sh"
    '';
  };

  home.file.".config/sketchybar/items/volume.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --add item volume right \
                 --set volume script="$PLUGIN_DIR/volume.sh" \
                 --subscribe volume volume_change
    '';
  };

  home.file.".config/sketchybar/items/battery.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --add item battery right \
                 --set battery update_freq=120             \
                               script="$PLUGIN_DIR/battery.sh" \
                 --subscribe battery system_woke power_source_change
    '';
  };

  home.file.".config/sketchybar/items/cpu.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --add item cpu right \
                 --set cpu update_freq=2       \
                           icon=􀧓              \
                           script="$PLUGIN_DIR/cpu.sh"
    '';
  };

  # ── plugins ────────────────────────────────────────────────────────────────

  home.file.".config/sketchybar/plugins/space.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      source "$CONFIG_DIR/colors.sh"
      WS="''${NAME#space.}"
      CURRENT="''${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
      if [ "$CURRENT" = "$WS" ]; then
        sketchybar --set $NAME background.drawing=on       \
                               background.color=0xffFFFFFF  \
                               icon.color=0xff000000
      else
        sketchybar --set $NAME background.drawing=off \
                               icon.color=0x66FFFFFF
      fi
    '';
  };

  home.file.".config/sketchybar/plugins/front_app.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      if [ "$SENDER" = "front_app_switched" ]; then
        sketchybar --set $NAME label="$INFO" icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$INFO")"
      fi
    '';
  };

  home.file.".config/sketchybar/plugins/media.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      STATE="$(echo "$INFO" | jq -r '.state')"
      if [ "$STATE" = "playing" ]; then
        MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
        sketchybar --set $NAME label="$MEDIA" drawing=on
      else
        sketchybar --set $NAME drawing=off
      fi
    '';
  };

  home.file.".config/sketchybar/plugins/calendar.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --set $NAME label="$(date +'%a %d %b %I:%M %p')"
    '';
  };

  home.file.".config/sketchybar/plugins/volume.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      if [ "$SENDER" = "volume_change" ]; then
        VOLUME=$INFO
        case $VOLUME in
          [6-9][0-9]|100) ICON="􀊩" ;;
          [3-5][0-9])      ICON="􀊥" ;;
          [1-9]|[1-2][0-9]) ICON="􀊡" ;;
          *)               ICON="􀊣" ;;
        esac
        sketchybar --set $NAME icon="$ICON" label="$VOLUME%"
      fi
    '';
  };

  home.file.".config/sketchybar/plugins/battery.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
      CHARGING=$(pmset -g batt | grep 'AC Power')
      if [ $PERCENTAGE = "" ]; then exit 0; fi
      case ''${PERCENTAGE} in
        9[0-9]|100) ICON="􀛨" ;;
        [6-8][0-9]) ICON="􀺸" ;;
        [3-5][0-9]) ICON="􀺶" ;;
        [1-2][0-9]) ICON="􀛩" ;;
        *)          ICON="􀛪" ;;
      esac
      if [[ $CHARGING != "" ]]; then ICON="􀢋"; fi
      sketchybar --set $NAME icon="$ICON" label="''${PERCENTAGE}%"
    '';
  };

  home.file.".config/sketchybar/plugins/cpu.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
      CPU_INFO=$(ps -eo pcpu,user)
      CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
      CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
      CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"
      sketchybar --set $NAME label="$CPU_PERCENT%"
    '';
  };

  home.file.".config/sketchybar/plugins/icon_map_fn.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      function icon_map() {
        case "$1" in
        "Ghostty") icon_result=":terminal:" ;;
        "Alacritty"|"Hyper"|"iTerm2"|"kitty"|"Terminal"|"WezTerm") icon_result=":terminal:" ;;
        "Arc") icon_result=":arc:" ;;
        "Brave Browser") icon_result=":brave_browser:" ;;
        "Firefox"|"Firefox Nightly") icon_result=":firefox:" ;;
        "Google Chrome"|"Chromium") icon_result=":google_chrome:" ;;
        "Safari") icon_result=":safari:" ;;
        "Tor Browser") icon_result=":tor_browser:" ;;
        "Cursor"|"Code"|"Code - Insiders") icon_result=":code:" ;;
        "Zed") icon_result=":zed:" ;;
        "Neovide"|"MacVim"|"Vim"|"VimR") icon_result=":vim:" ;;
        "IntelliJ IDEA") icon_result=":idea:" ;;
        "PyCharm") icon_result=":pycharm:" ;;
        "WebStorm") icon_result=":web_storm:" ;;
        "Android Studio") icon_result=":android_studio:" ;;
        "Xcode") icon_result=":xcode:" ;;
        "Obsidian") icon_result=":obsidian:" ;;
        "Notion") icon_result=":notion:" ;;
        "Bear") icon_result=":bear:" ;;
        "Notes") icon_result=":notes:" ;;
        "Discord"|"Discord Canary") icon_result=":discord:" ;;
        "Telegram") icon_result=":telegram:" ;;
        "Signal") icon_result=":signal:" ;;
        "WhatsApp") icon_result=":whats_app:" ;;
        "Microsoft Teams") icon_result=":microsoft_teams:" ;;
        "Slack") icon_result=":slack:" ;;
        "Spotify") icon_result=":spotify:" ;;
        "Music") icon_result=":music:" ;;
        "OBS") icon_result=":obsstudio:" ;;
        "IINA") icon_result=":default:" ;;
        "VLC") icon_result=":vlc:" ;;
        "Finder") icon_result=":finder:" ;;
        "System Preferences"|"System Settings") icon_result=":gear:" ;;
        "1Password") icon_result=":one_password:" ;;
        "Bitwarden") icon_result=":bit_warden:" ;;
        "Docker"|"Docker Desktop") icon_result=":docker:" ;;
        "OrbStack") icon_result=":docker:" ;;
        "Postman") icon_result=":default:" ;;
        "Sequel Ace") icon_result=":sequel_ace:" ;;
        "ChatGPT") icon_result=":default:" ;;
        "Calendar"|"Fantastical") icon_result=":calendar:" ;;
        "Mail"|"Superhuman") icon_result=":mail:" ;;
        "Preview") icon_result=":pdf:" ;;
        "Raycast") icon_result=":spotlight:" ;;
        "GitHub Desktop") icon_result=":git_hub:" ;;
        "Figma") icon_result=":figma:" ;;
        "Blender") icon_result=":blender:" ;;
        "Canary Mail"|"HEY"|"Mailspring"|"MailMate") icon_result=":mail:" ;;
        "Messages") icon_result=":messages:" ;;
        "FaceTime") icon_result=":face_time:" ;;
        "Reminders") icon_result=":reminders:" ;;
        "App Store") icon_result=":app_store:" ;;
        "Skype") icon_result=":skype:" ;;
        "Zoom"|"zoom.us") icon_result=":zoom:" ;;
        "Microsoft Word") icon_result=":microsoft_word:" ;;
        "Microsoft Excel") icon_result=":microsoft_excel:" ;;
        "Microsoft PowerPoint") icon_result=":microsoft_power_point:" ;;
        "Microsoft Edge") icon_result=":microsoft_edge:" ;;
        "Affinity Photo") icon_result=":affinity_photo:" ;;
        "Affinity Designer") icon_result=":affinity_designer:" ;;
        "Sketch") icon_result=":sketch:" ;;
        "Keynote") icon_result=":keynote:" ;;
        "Pages") icon_result=":pages:" ;;
        "Numbers") icon_result=":numbers:" ;;
        "Todoist") icon_result=":todoist:" ;;
        "Trello") icon_result=":trello:" ;;
        "Linear") icon_result=":linear:" ;;
        "ClickUp") icon_result=":click_up:" ;;
        "Emacs") icon_result=":emacs:" ;;
        "Atom") icon_result=":atom:" ;;
        "Sublime Text") icon_result=":sublime_text:" ;;
        "Warp") icon_result=":warp:" ;;
        "Default") icon_result=":default:" ;;
        *) icon_result=":default:" ;;
        esac
      }
      icon_map "$1"
      echo "$icon_result"
    '';
  };
}
