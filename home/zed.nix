{...}: {
  home.file.zed = {
    target = ".config/zed/settings.json";
    text = ''
    {
      "assistant": {
        "default_model": {
          "provider": "ollama",
          "model": "deepseek-r1:8b"
        },
        "version": "2"
      },
      "features": {
        "edit_prediction_provider": "zed"
      },
      "telemetry": {
        "metrics": false,
        "diagnostics": false
      },
      "vim_mode": true,
      "ui_font_size": 14,
      "buffer_font_size": 14,
      "buffer_font_family": "JetBrainsMono Nerd Font",
      "ui_font_family": ".SystemUIFont"
    }
    '';
  };
}
