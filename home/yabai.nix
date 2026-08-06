{...}: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # Load the scripting addition. This requires partially disabling SIP
      # (one-time manual step via Recovery Mode) - yabai still works in a
      # reduced capacity without it, this just fails silently otherwise.
      sudo yabai --load-sa 2>/dev/null || true
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa 2>/dev/null || true"

      yabai -m config layout bsp
      yabai -m config auto_balance off
      yabai -m config window_topmost on
      yabai -m config window_placement second_child

      yabai -m config top_padding    10
      yabai -m config bottom_padding 10
      yabai -m config left_padding   10
      yabai -m config right_padding  10
      yabai -m config window_gap     10

      yabai -m config mouse_follows_focus off
      yabai -m config focus_follows_mouse autofocus

      # rules
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^System Preferences$" manage=off

      # sketchybar integration: fire a custom event on space change so the
      # workspace pill updates instantly instead of relying on polling.
      yabai -m signal --add event=space_changed action='/opt/homebrew/bin/sketchybar --trigger yabai_workspace_change FOCUSED_WORKSPACE=$(/opt/homebrew/bin/yabai -m query --spaces --space | /usr/bin/grep -o "\"index\":[0-9]*" | /usr/bin/grep -o "[0-9]*")'

      echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      # focus window
      alt - h : /opt/homebrew/bin/yabai -m window --focus west
      alt - j : /opt/homebrew/bin/yabai -m window --focus south
      alt - k : /opt/homebrew/bin/yabai -m window --focus north
      alt - l : /opt/homebrew/bin/yabai -m window --focus east

      # swap window
      alt + shift - h : /opt/homebrew/bin/yabai -m window --swap west
      alt + shift - j : /opt/homebrew/bin/yabai -m window --swap south
      alt + shift - k : /opt/homebrew/bin/yabai -m window --swap north
      alt + shift - l : /opt/homebrew/bin/yabai -m window --swap east

      # resize window (shrink / grow)
      alt - minus : /opt/homebrew/bin/yabai -m window --resize left:-50:-50 2>/dev/null; /opt/homebrew/bin/yabai -m window --resize right:-50:-50 2>/dev/null; /opt/homebrew/bin/yabai -m window --resize bottom:-50:-50 2>/dev/null
      alt - equal : /opt/homebrew/bin/yabai -m window --resize left:50:50 2>/dev/null; /opt/homebrew/bin/yabai -m window --resize right:50:50 2>/dev/null; /opt/homebrew/bin/yabai -m window --resize bottom:50:50 2>/dev/null

      # switch layout
      alt - slash : /opt/homebrew/bin/yabai -m space --layout bsp
      alt - comma : /opt/homebrew/bin/yabai -m space --layout stack

      # focus space
      alt - 1 : /opt/homebrew/bin/yabai -m space --focus 1
      alt - 2 : /opt/homebrew/bin/yabai -m space --focus 2
      alt - 3 : /opt/homebrew/bin/yabai -m space --focus 3
      alt - 4 : /opt/homebrew/bin/yabai -m space --focus 4
      alt - 5 : /opt/homebrew/bin/yabai -m space --focus 5

      # move window to space and follow
      alt + shift - 1 : /opt/homebrew/bin/yabai -m window --space 1; /opt/homebrew/bin/yabai -m space --focus 1
      alt + shift - 2 : /opt/homebrew/bin/yabai -m window --space 2; /opt/homebrew/bin/yabai -m space --focus 2
      alt + shift - 3 : /opt/homebrew/bin/yabai -m window --space 3; /opt/homebrew/bin/yabai -m space --focus 3
      alt + shift - 4 : /opt/homebrew/bin/yabai -m window --space 4; /opt/homebrew/bin/yabai -m space --focus 4
      alt + shift - 5 : /opt/homebrew/bin/yabai -m window --space 5; /opt/homebrew/bin/yabai -m space --focus 5

      # float / unfloat window and center on screen
      alt - t : /opt/homebrew/bin/yabai -m window --toggle float; \
                /opt/homebrew/bin/yabai -m window --grid 4:4:1:1:2:2

      # toggle sticky(+float), topmost, picture-in-picture
      alt - p : /opt/homebrew/bin/yabai -m window --toggle sticky; \
                /opt/homebrew/bin/yabai -m window --toggle topmost; \
                /opt/homebrew/bin/yabai -m window --toggle pip
    '';
  };
}
