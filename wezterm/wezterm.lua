local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- Tab Bar
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Fonts
config.font_size = 14.0

return config
