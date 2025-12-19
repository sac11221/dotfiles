local wezterm = require 'wezterm'

return {
  adjust_window_size_when_changing_font_size = false,

  font = wezterm.font("NotoSansM Nerd Font Mono"),  -- Set your font here
  font_size = 14,                                 -- Adjust size as desired

  colors = {
    foreground = "#ffffff",  -- text color
    background = "#000000",  -- background color
  },

  hide_tab_bar_if_only_one_tab = true,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  -- Mouse bindings for zoom
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = "CTRL",
      action = wezterm.action.Multiple {
        wezterm.action.IncreaseFontSize,
      }
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = "CTRL",
      action = wezterm.action.DecreaseFontSize,
    },
  },
}
