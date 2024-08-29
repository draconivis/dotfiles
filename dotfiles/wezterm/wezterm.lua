-- Pull in the wezterm API
local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMonoNF")
config.leader = { key = "a", mods = "CTRL" }
config.disable_default_key_bindings = true
config.keys = {
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab,
	},
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal,
	},
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical,
	},
}
-- require("wez-tmux.plugin").apply_to_config(config, {})
-- require("wez-pain-control.plugin").apply_to_config(config, {})
workspace_switcher.set_zoxide_path("~/.nix-profile/bin/zoxide")
workspace_switcher.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
