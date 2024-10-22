local theme = {}
local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local os = os
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/default/"
theme.wallpaper = function()
	local wallpaper_dir = "/home/patrick/linux-stuff/wallpapers/landscape/"
	local wallpapers = {
		wallpaper_dir .. "spaceship.png",
		wallpaper_dir .. "Mega_Black_Hole_Normal_2.png",
		wallpaper_dir .. "Mega_Black_Hole.png",
		wallpaper_dir .. "Mega_Black_Hole_gigi.png",
		wallpaper_dir .. "fluffy_galaxy.png",
		wallpaper_dir .. "road_to_samarkand.png",
		wallpaper_dir .. "spooky_spill.jpg",
	}
	return wallpapers[math.random(#wallpapers)]
end
theme.font = "JetBrainsMono NF 10"

-- Catppuccin
-- local fg                                        = "#cdd6f4"
-- local focus                                     = "#cba6f7"
-- local urgent                                    = "#cdd6f4"
-- local bg                                        = "#1E1E2E"
-- local bg_urgent                                 = "#f38ba8"

-- Rose Pine Moon
-- local fg                                        = "#e0def4"
-- local focus                                     = "#3e8fb0" -- Pine
-- local urgent                                    = "#6e6a86"
-- local bg                                        = "#232136"
-- local bg_urgent                                 = "#eb6f92"

-- Kanagawa Wave
local fg = "#DCD7BA"
local focus = "#7E9CD8" -- Pine
local urgent = "#DCD7BA"
local bg = "#16161D"
local bg_urgent = "#C34043"

theme.fg_normal = fg
theme.menu_fg_normal = fg
theme.fg_focus = focus
theme.fg_urgent = urgent
theme.bg_normal = bg
theme.bg_focus = bg
theme.bg_urgent = bg_urgent
theme.border_normal = bg
theme.border_focus = focus
theme.border_marked = focus
theme.tasklist_bg_focus = bg
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.border_width = dpi(1)
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(0)
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.power_off = theme.dir .. "/icons/power-off.svg"
theme.terminal_icon = theme.dir .. "/icons/terminal.svg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
	--                     background     , foreground
	theme.menu_height,
	theme.bg_normal,
	theme.fg_focus
)

return theme
