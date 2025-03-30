local wezterm = require("wezterm")
local config = wezterm.config_builder() or {}
local act = wezterm.action

config.enable_wayland = true
config.adjust_window_size_when_changing_font_size = false
config.tiling_desktop_environments = { "Wayland" }

config.automatically_reload_config = true
-- config.front_end = "WebGpu"
-- config.front_end = "Software"

config.mux_enable_ssh_agent = false

-- don't care about tabs
config.enable_tab_bar = false

config.launch_menu = {
    {
        args = { "top" },
    },
    {
        -- Optional label to show in the launcher. If omitted, a label
        -- is derived from the `args`
        label = "Bash",
        -- The argument array to spawn.  If omitted the default program
        -- will be used as described in the documentation above
        args = { "bash", "-l" },

        -- You can specify an alternative current working directory;
        -- if you don't specify one then a default based on the OSC 7
        -- escape sequence will be used (see the Shell Integration
        -- docs), falling back to the home directory.
        -- cwd = "/some/path"

        -- You can override environment variables just for this command
        -- by setting this here.  It has the same semantics as the main
        -- set_environment_variables configuration option described above
        -- set_environment_variables = { FOO = "bar" },
    },
}

-- colorscheme
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
    {
        family = "Jet Brains Mono Nerd Font",
        weight = "Regular",
        harfbuzz_features = { "calt=1", "clig=1", "liga=1", "zero" },
        --- 0000
    },
    { family = "Noto Color Emoji", weight = "Regular" },
    "Symbols Nerd Font Mono",
    "Powerline Extra Symbols",
    "codicon",
    "Noto Sans Symbols",
    "Noto Sans Symbols2",
    "Font Awesome 6 Free",
})

config.font_size = 12

config.line_height = 1.5
config.underline_position = "-5px"
-- config.underline_thickness = "100%"
config.command_palette_font_size = 12

config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
}

config.tiling_desktop_environments = {
    "X11 LG3D",
    "X11 bspwm",
    "X11 i3",
    "X11 dwm",
    "Wayland",
}

config.adjust_window_size_when_changing_font_size = false

-- you may also use the "https://github.com/Xarvex/presentation.wez" mirror
wezterm.plugin.require("https://gitlab.com/xarvex/presentation.wez").apply_to_config(config, {
    font_size_multiplier = 1.8,                  -- sets for both "presentation" and "presentation_full"
    presentation = {
        keybind = { key = "t", mods = "SHIFT|SUPER" }, -- setting a keybind
    },
    presentation_full = {
        font_weight = "Bold",
        font_size_multiplier = 2.4,              -- overwrites "font_size_multiplier" for "presentation_full"
        keybind = { key = "y", mods = "SHIFT|SUPER" }, -- setting a keybind
    },
})


config.leader = { key = "a", mods = "CTRL" }

config.keys = {
    { key = "a",     mods = "LEADER|CTRL",  action = wezterm.action({ SendString = "\x01" }) },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
    },
    {
        key = "\\",
        mods = "LEADER",
        action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
    { key = "z",     mods = "LEADER",       action = "TogglePaneZoomState" },
    { key = "c",     mods = "LEADER",       action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
    { key = "h",     mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "j",     mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    { key = "k",     mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "l",     mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "H",     mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
    { key = "J",     mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
    { key = "K",     mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
    { key = "L",     mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
    { key = "1",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 0 }) },
    { key = "2",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 1 }) },
    { key = "3",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 2 }) },
    { key = "4",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 3 }) },
    { key = "5",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 4 }) },
    { key = "6",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 5 }) },
    { key = "7",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 6 }) },
    { key = "8",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 7 }) },
    { key = "9",     mods = "LEADER",       action = wezterm.action({ ActivateTab = 8 }) },
    { key = "&",     mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
    { key = "d",     mods = "LEADER",       action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    { key = "Tab",   mods = "CTRL",         action = act.ActivateTabRelative(1) },
    { key = "Tab",   mods = "SHIFT|CTRL",   action = act.ActivateTabRelative(-1) },
    { key = "Enter", mods = "ALT",          action = act.ToggleFullScreen },
    { key = "*",     mods = "CTRL",         action = act.ActivateTab(7) },
    { key = "*",     mods = "SHIFT|CTRL",   action = act.ActivateTab(7) },
    { key = "+",     mods = "CTRL",         action = act.IncreaseFontSize },
    { key = "+",     mods = "SHIFT|CTRL",   action = act.IncreaseFontSize },
    {
        key = ",",
        mods = "CTRL",
        action = act.SpawnCommandInNewWindow({
            args = { "/bin/zsh", "-c", "nvim" },
            domain = "CurrentPaneDomain",
            set_environment_variables = { TERM = "screen-256color" },
        }),
    },
    { key = "-", mods = "CTRL",       action = act.DecreaseFontSize },
    { key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
    { key = "-", mods = "SUPER",      action = act.DecreaseFontSize },
    { key = "0", mods = "CTRL",       action = act.ResetFontSize },
    { key = "0", mods = "SHIFT|CTRL", action = act.ResetFontSize },
    { key = "0", mods = "SUPER",      action = act.ResetFontSize },
    { key = "C", mods = "CTRL",       action = act.CopyTo("Clipboard") },
    { key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
    { key = "F", mods = "CTRL",       action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "F", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "K", mods = "CTRL",       action = act.ClearScrollback("ScrollbackOnly") },
    { key = "K", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
    { key = "L", mods = "CTRL",       action = act.ShowDebugOverlay },
    { key = "L", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "M", mods = "CTRL",       action = act.Hide },
    { key = "M", mods = "SHIFT|CTRL", action = act.Hide },
    { key = "N", mods = "CTRL",       action = act.SpawnWindow },
    { key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
    { key = "P", mods = "CTRL",       action = act.ActivateCommandPalette },
    { key = "R", mods = "CTRL",       action = act.ReloadConfiguration },
    { key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
    { key = "T", mods = "CTRL",       action = act.SpawnTab("CurrentPaneDomain") },
    { key = "T", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
    {
        key = "U",
        mods = "CTRL",
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },
    {
        key = "U",
        mods = "SHIFT|CTRL",
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },
    { key = "W", mods = "CTRL",        action = act.CloseCurrentTab({ confirm = true }) },
    { key = "W", mods = "SHIFT|CTRL",  action = act.CloseCurrentTab({ confirm = true }) },
    { key = "X", mods = "CTRL",        action = act.ActivateCopyMode },
    { key = "X", mods = "SHIFT|CTRL",  action = act.ActivateCopyMode },
    { key = "Z", mods = "CTRL",        action = act.TogglePaneZoomState },
    { key = "Z", mods = "SHIFT|CTRL",  action = act.TogglePaneZoomState },
    { key = "[", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
    { key = "^", mods = "CTRL",        action = act.ActivateTab(5) },
    { key = "^", mods = "SHIFT|CTRL",  action = act.ActivateTab(5) },
    { key = "_", mods = "CTRL",        action = act.DecreaseFontSize },
    { key = "_", mods = "SHIFT|CTRL",  action = act.DecreaseFontSize },
    { key = "c", mods = "SHIFT|CTRL",  action = act.CopyTo("Clipboard") },
    { key = "c", mods = "SUPER",       action = act.CopyTo("Clipboard") },
    { key = "f", mods = "SHIFT|CTRL",  action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "f", mods = "SUPER",       action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "k", mods = "SHIFT|CTRL",  action = act.ClearScrollback("ScrollbackOnly") },
    { key = "k", mods = "SUPER",       action = act.ClearScrollback("ScrollbackOnly") },
    { key = "l", mods = "SHIFT|CTRL",  action = act.ShowDebugOverlay },
    { key = "m", mods = "SHIFT|CTRL",  action = act.Hide },
    { key = "m", mods = "SUPER",       action = act.Hide },
    { key = "n", mods = "SHIFT|CTRL",  action = act.SpawnWindow },
    { key = "n", mods = "SUPER",       action = act.SpawnWindow },
    { key = "r", mods = "SHIFT|CTRL",  action = act.ReloadConfiguration },
    { key = "r", mods = "SUPER",       action = act.ReloadConfiguration },
    { key = "t", mods = "SHIFT|CTRL",  action = act.SpawnTab("CurrentPaneDomain") },
    { key = "t", mods = "SUPER",       action = act.SpawnTab("CurrentPaneDomain") },
    {
        key = "u",
        mods = "SHIFT|CTRL",
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },
    { key = "V",          mods = "SUPER|SHIFT",    action = act.PasteFrom("Clipboard") },
    { key = "w",          mods = "SHIFT|CTRL",     action = act.CloseCurrentTab({ confirm = true }) },
    { key = "w",          mods = "SUPER",          action = act.CloseCurrentTab({ confirm = true }) },
    { key = "x",          mods = "SHIFT|CTRL",     action = act.ActivateCopyMode },
    { key = "z",          mods = "SHIFT|CTRL",     action = act.TogglePaneZoomState },
    { key = "{",          mods = "SUPER",          action = act.ActivateTabRelative(-1) },
    { key = "{",          mods = "SHIFT|SUPER",    action = act.ActivateTabRelative(-1) },
    { key = "}",          mods = "SUPER",          action = act.ActivateTabRelative(1) },
    { key = "}",          mods = "SHIFT|SUPER",    action = act.ActivateTabRelative(1) },
    { key = "phys:Space", mods = "SHIFT|CTRL",     action = act.QuickSelect },
    { key = "PageUp",     mods = "SHIFT",          action = act.ScrollByPage(-1) },
    { key = "PageUp",     mods = "CTRL",           action = act.ActivateTabRelative(-1) },
    { key = "PageUp",     mods = "SHIFT|CTRL",     action = act.MoveTabRelative(-1) },
    { key = "PageDown",   mods = "SHIFT",          action = act.ScrollByPage(1) },
    { key = "PageDown",   mods = "CTRL",           action = act.ActivateTabRelative(1) },
    { key = "PageDown",   mods = "SHIFT|CTRL",     action = act.MoveTabRelative(1) },
    { key = "LeftArrow",  mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Left") },
    { key = "LeftArrow",  mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "RightArrow", mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Right") },
    { key = "RightArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "UpArrow",    mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Up") },
    { key = "UpArrow",    mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "DownArrow",  mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Down") },
    { key = "DownArrow",  mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "Insert",     mods = "SHIFT",          action = act.PasteFrom("PrimarySelection") },
    { key = "Insert",     mods = "CTRL",           action = act.CopyTo("PrimarySelection") },
    { key = "Copy",       mods = "NONE",           action = act.CopyTo("Clipboard") },
    { key = "Paste",      mods = "NONE",           action = act.PasteFrom("Clipboard") },
}

return config
