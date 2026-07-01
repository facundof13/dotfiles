local wezterm = require('wezterm')

local config = wezterm.config_builder()

-- Enable the Kitty keyboard protocol so apps can distinguish
-- Ctrl+J/Ctrl+K/etc. from Enter and other legacy control codes.
config.enable_kitty_keyboard = true

return config
