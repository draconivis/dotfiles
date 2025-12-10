local function getHeaderArt()
	local headerArts = {
		[[
  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆
   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
         ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄
          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
         ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
 ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄
⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆
      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃    ]],

		[[
 ██████   █████                   █████   █████  ███
░░██████ ░░███                   ░░███   ░░███  ░░░
 ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████
 ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███
 ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███
 ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███
 █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ]],

		[[
     ___           ___           ___           ___                       ___
    /\__\         /\  \         /\  \         /\__\          ___        /\__\
   /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |
  /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |
 /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__
/:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\
\/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /
    |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  /
    |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /
    /:/  /       \:\__\        \::/  /       ----         \/__/         /:/  /
    \/__/         \/__/         \/__/                                   \/__/    ]],

		[[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],

		[[
██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗
╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝
 ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]],
		[[
__/\\\________/\\\_____/\\\\\\\\\\\__________/\\\\\\\\\________/\\\________/\\\\\\\\\\\\_____/\\\\\\\\\\\\\\\_
 _\/\\\_______\/\\\___/\\\/////////\\\_____/\\\////////___/\\\_\/\\\__/\\\_\/\\\////////\\\__\/\\\///////////__
  _\//\\\______/\\\___\//\\\______\///____/\\\/___________\////\\\\\\\\\//__\/\\\______\//\\\_\/\\\_____________
   __\//\\\____/\\\_____\////\\\__________/\\\________________\////\\\//_____\/\\\_______\/\\\_\/\\\\\\\\\\\_____
    ___\//\\\__/\\\_________\////\\\______\/\\\_________________/\\\\\\\\\____\/\\\_______\/\\\_\/\\\///////______
     ____\//\\\/\\\_____________\////\\\___\//\\\_____________/\\\///\\\///\\\_\/\\\_______\/\\\_\/\\\_____________
      _____\//\\\\\_______/\\\______\//\\\___\///\\\__________\///__\/\\\_\///__\/\\\_______/\\\__\/\\\_____________
       ______\//\\\_______\///\\\\\\\\\\\/______\////\\\\\\\\\_______\///________\/\\\\\\\\\\\\/___\/\\\\\\\\\\\\\\\_
        _______\///__________\///////////___________\/////////____________________\////////////_____\///////////////__]],
	}
	math.randomseed(os.time())
	return headerArts[math.random(#headerArts)]
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				header = getHeaderArt(),
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "M",
						desc = "Mason",
						action = ":Mason",
						enabled = package.loaded.mason ~= nil,
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = true },
		lazygit = { enabled = true },
		gitbrowse = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		picker = {
			enabled = true,
			sources = { explorer = { replace_netrw = true } },
			formatters = { file = { truncate = 100 } },
			layout = { width = 0.95, height = 0.95 },
		},
		quickfile = { enabled = true },
		rename = { enabled = true },
	},
	keys = {
		-- lazygit
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>go",
			function()
				Snacks.gitbrowse.open()
			end,
			desc = "Git Blame Line",
		},
		-- Snacks.gitbrowse.open(opts)
		-- picker
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sG",
			function()
				Snacks.picker.grep({ hidden = true, ignored = true })
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sF",
			function()
				Snacks.picker.files({ hidden = true, ignored = true })
			end,
			desc = "Find Files",
		},
		{
			"<leader>s.",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent files",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>sW",
			function()
				Snacks.picker.grep_word({ hidden = true, ignored = true })
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		-- LSP
		{
			"grd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"grD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"grr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"grI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		-- { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition", },
		-- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		-- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
	},
}
