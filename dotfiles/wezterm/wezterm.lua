local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local act = wezterm.action
local config = wezterm.config_builder()
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Light"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Catppucin Macchiato"
		-- return "flexoki-dark"
		return "Rosé Pine (Gogh)"
		-- return "Everforest Dark Medium (Gogh)"
	else
		-- return "Catppucin Latte"
		-- return "flexoki-light"
		return "Rosé Pine Dawn (Gogh)"
		-- return "Everforest Light Medium (Gogh)"
	end
end
-- Spawn a fish shell in login mode
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
config.max_fps = 120
config.font_size = 16
config.font = wezterm.font("Maple Mono")
config.color_scheme = scheme_for_appearance(get_appearance())
config.tab_bar_at_bottom = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.leader = { key = "a", mods = "CTRL" }
config.disable_default_key_bindings = true
-- if this is disabled, used the right option for umlauts, see https://wezfurlong.org/wezterm/config/keyboard-concepts.html#macos-left-and-right-option-key
config.send_composed_key_when_left_alt_is_pressed = true
config.keys = {
	-- wezterm controls
	{ key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },
	-- { key = "u", mods = "CTRL|SHIFT", action = wezterm.plugin.update_all() },
	{ key = "s", mods = "LEADER", action = workspace_switcher.switch_workspace() },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "C", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "a", mods = "LEADER", action = act.SwitchToWorkspace({ name = "default" }) },

	-- tab controls
	--- create new tab
	{ key = "c", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	--- switch to right tab
	{ key = "n", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "RightArrow", mods = "ALT", action = act.ActivateTabRelative(1) },
	--- switch to left tab
	{ key = "p", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "LeftArrow", mods = "ALT", action = act.ActivateTabRelative(-1) },
	--- switch to last active tab
	-- { key = "a",          mods = "ALT",        action = act.ActivateLastTab },
	--- move tab right
	{ key = ">", mods = "ALT|SHIFT", action = act.MoveTabRelative(1) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = act.MoveTabRelative(1) },
	--- move tab left
	{ key = "<", mods = "ALT|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = act.MoveTabRelative(-1) },

	-- pane controls
	--- splitting
	{ key = "|", mods = "ALT|SHIFT", action = act.SplitHorizontal },
	{ key = '"', mods = "ALT|SHIFT", action = act.SplitVertical },
	--- closing
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	--- activate resizing
	{
		key = "r",
		mods = "ALT",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
	--- rotating
	{ key = "q", mods = "ALT", action = act.RotatePanes("Clockwise") },
	--- switch active pane
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "h", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "j", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "k", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "l", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },
	--- scrollback
	{ key = "UpArrow", mods = "ALT", action = act.ScrollByPage(-0.6) },
	{ key = "b", mods = "ALT", action = act.ScrollByPage(-0.6) },
	{ key = "DownArrow", mods = "ALT", action = act.ScrollByPage(0.6) },
	{ key = "f", mods = "ALT", action = act.ScrollByPage(0.6) },
	--- search in scrollback
	{ key = "/", mods = "ALT", action = act.Search({ CaseInSensitiveString = "" }) },
}

-- for i = 1, 9 do
-- 	-- pane controls, continued
-- 	table.insert(config.keys, { key = tostring(i), mods = "ALT", action = act.ActivateTab(i - 1) })
-- 	table.insert(config.keys, { key = tostring(i), mods = "ALT|CTRL", action = act.MoveTab(i - 1) })
-- end

config.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
	search_mode = {
		{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
	},
}

tabline.setup({
	options = {
		icons_enabled = true,
		theme = config.color_scheme,
		section_separators = {
			left = "",
			right = "",
		},
		component_separators = {
			left = "",
			right = "",
		},
		tab_separators = {
			left = "",
			right = "",
		},
	},
	sections = {
		tabline_a = {},
		tabline_b = {},
		tabline_c = { " " },
		tab_active = { "index", { "process", padding = { left = 0, right = 1 } } },
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = {},
		tabline_y = { "mode" },
		tabline_z = { "workspace" },
	},
	extensions = {
		"smart_workspace_switcher",
	},
})

-- apply plugins
-- workspace_switcher.set_zoxide_path("~/.nix-profile/bin/zoxide") --zoxide installed from Nix
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide" --zoxide installed from brew
workspace_switcher.apply_to_config(config)
tabline.apply_to_config(config)

-- add back window decoration
-- config.window_decorations = "TITLE|RESIZE"

-- and finally, return the configuration to wezterm
return config
