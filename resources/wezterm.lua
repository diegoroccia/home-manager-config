local wezterm = require("wezterm")
local config = wezterm.config_builder() or {}

config.enable_wayland = true
config.automatically_reload_config = true
config.front_end = "OpenGL"

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

config.font_size = 14

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

config.leader = { key = "a", mods = "CTRL" }
-- config.keys = require("keys")

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
	font_size_multiplier = 1.8, -- sets for both "presentation" and "presentation_full"
	presentation = {
		keybind = { key = "t", mods = "SHIFT|SUPER" }, -- setting a keybind
	},
	presentation_full = {
		font_weight = "Bold",
		font_size_multiplier = 2.4, -- overwrites "font_size_multiplier" for "presentation_full"
		keybind = { key = "y", mods = "SHIFT|SUPER" }, -- setting a keybind
	},
})

local wezterm = require("wezterm")

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.fa_clock_o .. " " .. date },
	}))
end)
return config
