{pkgs, ...}: let
  nordTerminal = pkgs.runCommand "nord.terminal" {nativeBuildInputs = [pkgs.python3];} ''
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
        "name": "Nord",
        "type": "Window Settings",
        "ProfileCurrentVersion":      2.07,
        "BackgroundColor":            nscolor(0.18039, 0.20392, 0.25098),
        "TextColor":                  nscolor(0.84706, 0.87059, 0.91373),
        "BoldTextColor":              nscolor(0.92549, 0.93725, 0.95686),
        "SelectionColor":             nscolor(0.26275, 0.29804, 0.36863),
        "CursorColor":                nscolor(0.84706, 0.87059, 0.91373),
        "ANSIBlackColor":             nscolor(0.23137, 0.25882, 0.32157),
        "ANSIRedColor":               nscolor(0.74902, 0.38039, 0.41569),
        "ANSIGreenColor":             nscolor(0.63922, 0.74510, 0.54902),
        "ANSIYellowColor":            nscolor(0.92157, 0.79608, 0.54510),
        "ANSIBlueColor":              nscolor(0.50588, 0.63137, 0.75686),
        "ANSIMagentaColor":           nscolor(0.70588, 0.55686, 0.67843),
        "ANSICyanColor":              nscolor(0.53333, 0.75294, 0.81569),
        "ANSIWhiteColor":             nscolor(0.89804, 0.91373, 0.94118),
        "ANSIBrightBlackColor":       nscolor(0.29804, 0.33725, 0.41569),
        "ANSIBrightRedColor":         nscolor(0.74902, 0.38039, 0.41569),
        "ANSIBrightGreenColor":       nscolor(0.63922, 0.74510, 0.54902),
        "ANSIBrightYellowColor":      nscolor(0.92157, 0.79608, 0.54510),
        "ANSIBrightBlueColor":        nscolor(0.50588, 0.63137, 0.75686),
        "ANSIBrightMagentaColor":     nscolor(0.70588, 0.55686, 0.67843),
        "ANSIBrightCyanColor":        nscolor(0.56078, 0.73725, 0.73333),
        "ANSIBrightWhiteColor":       nscolor(0.92549, 0.93725, 0.95686),
        "columnCount":                220,
        "rowCount":                   50,
    }

    with open(sys.argv[1], "wb") as f:
        plistlib.dump(profile, f, fmt=plistlib.FMT_XML)
    EOF
        python3 gen.py "$out"
  '';
in {
  home.file.nordTerminal = {
    target = "Library/Application Support/nord.terminal";
    source = nordTerminal;
  };

  home.activation.importNordTerminal = ''
    /usr/bin/open "$HOME/Library/Application Support/nord.terminal" 2>/dev/null || true
    /usr/bin/defaults write com.apple.Terminal "Default Window Settings" -string "Nord"
    /usr/bin/defaults write com.apple.Terminal "Startup Window Settings" -string "Nord"
  '';
}
