-- Pull in the wezterm API
--@type Wezterm
local wezterm = require("wezterm")

wezterm.battery_info()

-- This will hold the configuration.
local config = wezterm.config_builder()

local surround_padding = 11

-- This is where you actually apply your config choices

-- config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("BigBlueTerm437 Nerd Font", {})
config.font = wezterm.font("DaddyTimeMono Nerd Font", {})
-- config.font = wezterm.font("HeavyData Nerd Font", {})


config.font_size = 11

config.default_prog = { "powershell.exe" }
config.initial_cols = 80
config.initial_rows = 30

-- theme
-- config.color_scheme = 'astromouse (terminal.sexy)'
-- config.color_scheme = 'Atelier Cave (base16)'
-- config.color_scheme = 'Atom (Gogh)'
-- config.color_scheme = 'Breath Darker (Gogh)'
-- config.color_scheme = 'Dark Ocean (terminal.sexy)'
-- config.color_scheme = 'Dark Violet (base16)'
-- config.color_scheme = 'darkermatrix'
-- config.color_scheme = 'Dracula (base16)'
-- config.color_scheme = 'Erebus (terminal.sexy)'
-- config.color_scheme = 'FarSide (terminal.sexy)'
config.color_scheme = 'Fairy Floss Dark (Gogh)'
-- config.color_scheme = 'Isotope (base16)'
-- config.color_scheme = 'Sakura'
-- config.color_scheme = 'Scarlet Protocol'
-- config.color_scheme = 'UnderTheSea'

config.window_frame = {
  border_left_width = '0.5cell',
  border_right_width = '0.5cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell',
  border_left_color = 'purple',
  border_right_color = 'purple',
  border_bottom_color = 'purple',
  border_top_color = 'purple',
}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 1
config.window_padding = {
	left = surround_padding,
	right = surround_padding,
	top = surround_padding,
	bottom = 0,
}

config.enable_scroll_bar = true

config.leader = {
	key = " ",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}
config.keys = {
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "H",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "L",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 8 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 8 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 8 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 8 }),
	},
}

-- to navigate to tab number i
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true

-- little icon if leader key is active
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#282A36" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

return config