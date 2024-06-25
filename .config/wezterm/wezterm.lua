local wezterm = require('wezterm')
local config = wezterm.config_builder()
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", {
  weight = 'Medium',
})

config.line_height = 1
config.font_size = 16
config.freetype_load_flags = 'NO_HINTING'
config.color_scheme = 'tokyonight_night'
config.hide_tab_bar_if_only_one_tab = true
-- config.native_macos_fullscreen_mode = true
config.scrollback_lines = 100000
config.automatically_reload_config = true
config.freetype_render_target = "HorizontalLcd"

return config
