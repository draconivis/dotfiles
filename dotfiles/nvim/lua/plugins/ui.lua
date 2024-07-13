return {
	{ -- startup dashboard
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			--require'alpha'.setup(require'alpha.themes.dashboard'.config)
			require("alpha").setup(require("alphaConf").config)
		end,
	},
	{ -- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				-- theme = "catppuccin",
				icons_enabled = true,
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"catppuccin/nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("catppuccin-mocha")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{ -- indentation guides
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		-- See `:help gitsigns` to understand what the configuration keys do
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				vim.keymap.set(
					"n",
					"<leader>gp",
					require("gitsigns").preview_hunk,
					{ buffer = bufnr, desc = "Preview git hunk" }
				)
			end,
		},
	},
	{ -- inline git blame
		"f-person/git-blame.nvim",
		opts = {
			enabled = false,
			schedule_event = "CursorHold",
			clear_event = "CursorHoldI",
		},
	},
	{
		-- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
				["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			})

			-- visual mode
			require("which-key").register({
				["<leader>h"] = { "Git [H]unk" },
			}, { mode = "v" })
		end,
	},
	{ -- file explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			vim.keymap.set("n", "<leader>n", function()
				require("neo-tree.command").execute({
					toggle = true,
				})
			end, { desc = "Open [N]eotree" })
			vim.keymap.set("n", "-", function()
				local reveal_file = vim.fn.expand("%:p")
				if reveal_file == "" then
					reveal_file = vim.fn.getcwd()
				else
					local f = io.open(reveal_file, "r")
					if f then
						f.close(f)
					else
						reveal_file = vim.fn.getcwd()
					end
				end
				require("neo-tree.command").execute({
					action = "focus", -- OPTIONAL, this is the default value
					source = "filesystem", -- OPTIONAL, this is the default value
					position = "left", -- OPTIONAL, this is the default value
					reveal_file = reveal_file, -- path to file or folder to reveal
					reveal_force_cwd = true, -- change cwd without asking if needed
				})
			end, { desc = "Open neo-tree at current file or working directory" })
		end,
	},
	{ -- vim command line replacement, notifications, and more
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
}
-- vim: set ts=2 sw=2 tw=0 noet
