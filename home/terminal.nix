{pkgs, ...}: let
  gruvboxTerminal = pkgs.runCommand "gruvbox-dark-hard.terminal" {nativeBuildInputs = [pkgs.python3];} ''
        cat > gen.py << 'EOF'
    import plistlib, sys

    def nscolor(r, g, b):
        return plistlib.dumps({
            "$archiver": "NSKeyedArchiver",
            "$objects": [
                "$null",
                {
                    "$class": plistlib.UID(2),
                    "NSColorSpace": 1,
                    "NSRGB": f"{r} {g} {b}".encode(),
                },
                {"$classname": "NSColor", "$classes": ["NSColor", "NSObject"]},
            ],
            "$top": {"root": plistlib.UID(1)},
            "$version": 100000,
        }, fmt=plistlib.FMT_BINARY)

    profile = {
        "name": "Gruvbox Dark Hard",
        "type": "Window Settings",
        "ProfileCurrentVersion":      2.07,
        "BackgroundColor":            nscolor(0.07059, 0.06667, 0.06275),
        "TextColor":                  nscolor(0.85882, 0.83137, 0.76078),
        "BoldTextColor":              nscolor(0.92157, 0.85882, 0.69804),
        "SelectionColor":             nscolor(0.23922, 0.21961, 0.18824),
        "CursorColor":                nscolor(0.85882, 0.83137, 0.76078),
        "ANSIBlackColor":             nscolor(0.15686, 0.14902, 0.13333),
        "ANSIRedColor":               nscolor(0.80000, 0.14118, 0.11373),
        "ANSIGreenColor":             nscolor(0.59608, 0.59216, 0.10196),
        "ANSIYellowColor":            nscolor(0.84314, 0.60000, 0.12941),
        "ANSIBlueColor":              nscolor(0.27059, 0.52157, 0.53333),
        "ANSIMagentaColor":           nscolor(0.69412, 0.38431, 0.52549),
        "ANSICyanColor":              nscolor(0.40784, 0.61569, 0.41569),
        "ANSIWhiteColor":             nscolor(0.66275, 0.60000, 0.51765),
        "ANSIBrightBlackColor":       nscolor(0.57255, 0.51373, 0.45490),
        "ANSIBrightRedColor":         nscolor(0.98431, 0.28627, 0.20000),
        "ANSIBrightGreenColor":       nscolor(0.72157, 0.73333, 0.14902),
        "ANSIBrightYellowColor":      nscolor(0.98039, 0.74118, 0.18431),
        "ANSIBrightBlueColor":        nscolor(0.51373, 0.64706, 0.59608),
        "ANSIBrightMagentaColor":     nscolor(0.82745, 0.52549, 0.60784),
        "ANSIBrightCyanColor":        nscolor(0.55686, 0.75294, 0.48627),
        "ANSIBrightWhiteColor":       nscolor(0.92157, 0.85882, 0.69804),
        "columnCount":                220,
        "rowCount":                   50,
    }

    with open(sys.argv[1], "wb") as f:
        plistlib.dump(profile, f, fmt=plistlib.FMT_XML)
    EOF
        python3 gen.py "$out"
  '';
in {
  home.file.gruvboxTerminal = {
    target = "Library/Application Support/gruvbox-dark-hard.terminal";
    source = gruvboxTerminal;
  };

  home.activation.importGruvboxTerminal = ''
    /usr/bin/open "$HOME/Library/Application Support/gruvbox-dark-hard.terminal" 2>/dev/null || true
    /usr/bin/defaults write com.apple.Terminal "Default Window Settings" -string "Gruvbox Dark Hard"
    /usr/bin/defaults write com.apple.Terminal "Startup Window Settings" -string "Gruvbox Dark Hard"
  '';
}
