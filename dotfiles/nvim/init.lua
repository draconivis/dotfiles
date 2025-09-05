-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = false

-- disable line breaks
vim.opt.wrap = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

--inline diagnostics
vim.diagnostic.config({
	-- virtual_lines = true,
	virtual_text = true,
})

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- fzf
vim.opt.rtp:append("/opt/homebrew/bin/fzf")

-- [[ Basic Keymaps ]]
vim.api.nvim_create_user_command("Wa", function()
	vim.cmd("wa")
end, {})
vim.api.nvim_create_user_command("Wqa", function()
	vim.cmd("wqa")
end, {})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- vim.opt.hlsearch = true // CHECK
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Move V-Lines up / down, by Primeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current Line Up" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite current buffer" })
vim.keymap.set("n", "<leader>a", "<cmd>wa<CR>", { desc = "[W]rite [a]ll buffers" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- remap tab to c-6
vim.keymap.set("n", "<TAB>", "<C-^>", { desc = "Alternate buffers" })

-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

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
    /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   
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

-- [[ Configure and install plugins ]]
require("lazy").setup({
	spec = {
		"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically
		"tpope/vim-repeat", -- Make dot (.) repeats work with more things
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
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
					local gitsigns = require("gitsigns")
					vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr, desc = "View diff" })
					-- vim.keymap.set(
					-- 	"n",
					-- 	"<leader>gsf",
					-- 	gitsigns.stage_buffer,
					-- 	{ buffer = bufnr, desc = "Stage buffer" }
					-- )
					vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
					vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
				end,
			},
		},
		{ -- Useful plugin to show you pending keybinds.
			"folke/which-key.nvim",
			event = "VimEnter", -- Sets the loading event to 'VimEnter'
			opts = {
				-- delay between pressing a key and opening which-key (milliseconds)
				-- this setting is independent of vim.opt.timeoutlen
				delay = 0,
				icons = {
					-- set icon mappings to true if you have a Nerd Font
					mappings = vim.g.have_nerd_font,
					-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
					-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
					keys = vim.g.have_nerd_font and {} or {
						Up = "<Up> ",
						Down = "<Down> ",
						Left = "<Left> ",
						Right = "<Right> ",
						C = "<C-…> ",
						M = "<M-…> ",
						D = "<D-…> ",
						S = "<S-…> ",
						CR = "<CR> ",
						Esc = "<Esc> ",
						ScrollWheelDown = "<ScrollWheelDown> ",
						ScrollWheelUp = "<ScrollWheelUp> ",
						NL = "<NL> ",
						BS = "<BS> ",
						Space = "<Space> ",
						Tab = "<Tab> ",
						F1 = "<F1>",
						F2 = "<F2>",
						F3 = "<F3>",
						F4 = "<F4>",
						F5 = "<F5>",
						F6 = "<F6>",
						F7 = "<F7>",
						F8 = "<F8>",
						F9 = "<F9>",
						F10 = "<F10>",
						F11 = "<F11>",
						F12 = "<F12>",
					},
				},

				-- Document existing key chains
				spec = {
					{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
					{ "<leader>g", group = "[G]it", mode = { "n", "x" } },
					{ "<leader>r", group = "[R]ename" },
					{ "<leader>s", group = "[S]earch" },
					{ "<leader>t", group = "[T]oggle" },
				},
			},
		},
		-- LSP Plugins
		{
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			-- Main LSP Configuration
			"neovim/nvim-lspconfig",
			dependencies = {
				"mason-org/mason.nvim",
				"mason-org/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",

				-- Useful status updates for LSP.
				{ "j-hui/fidget.nvim", opts = {} },

				-- Allows extra capabilities provided by nvim-cmp
				-- "hrsh7th/cmp-nvim-lsp",
				"saghen/blink.cmp",
			},
			config = function()
				--  This function gets run when an LSP attaches to a particular buffer.
				--    That is to say, every time a new file is opened that is associated with
				--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
				--    function will be executed to configure the current buffer
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						-- Rename the variable under your cursor.
						--  Most Language Servers support renaming across files, etc.
						map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						-- The following two autocommands are used to highlight references of the
						-- word under your cursor when your cursor rests there for a little while.
						--    See `:help CursorHold` for information about when this is executed
						--
						-- When you move your cursor, the highlights will be cleared (the second autocommand).
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client
							and client:supports_method(
								vim.lsp.protocol.Methods.textDocument_documentHighlight,
								event.buf
							)
						then
							local highlight_augroup =
								vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "kickstart-lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- The following code creates a keymap to toggle inlay hints in your
						-- code, if the language server you are using supports them
						--
						-- This may be unwanted, since they displace some of your code
						if
							client
							and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
						then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end,
				})

				-- Change diagnostic symbols in the sign column (gutter)
				-- if vim.g.have_nerd_font then
				--   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
				--   local diagnostic_signs = {}
				--   for type, icon in pairs(signs) do
				--     diagnostic_signs[vim.diagnostic.severity[type]] = icon
				--   end
				--   vim.diagnostic.config { signs = { text = diagnostic_signs } }
				-- end

				-- LSP servers and clients are able to communicate to each other what features they support.
				--  By default, Neovim doesn't support everything that is in the LSP specification.
				--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
				--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
				-- local capabilities = vim.lsp.protocol.make_client_capabilities()
				-- capabilities =
				-- 	vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
				--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
				local capabilities = require("blink-cmp").get_lsp_capabilities()

				-- Enable the following language servers
				--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
				--
				--  Add any additional override configuration in the following tables. Available keys are:
				--  - cmd (table): Override the default command used to start the server
				--  - filetypes (table): Override the default list of associated filetypes for the server
				--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
				--  - settings (table): Override the default settings passed when initializing the server.
				--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
				local servers = {
					twiggy_language_server = {
						-- settings = {
						-- 	twiggy = {
						-- 		framework = "symfony",
						-- 		phpExecutable = "php",
						-- 		symfonyConsolePath = "bin/console",
						-- 	},
						-- },
					},
					phpactor = {},
					ts_ls = {},
					lua_ls = {
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					},
				}

				-- Ensure the servers and tools above are installed
				--
				-- To check the current status of installed tools and/or manually install
				-- other tools, you can run
				--    :Mason
				--
				-- You can press `g?` for help in this menu.
				--
				-- `mason` had to be setup earlier: to configure its options see the
				-- `dependencies` table for `nvim-lspconfig` above.
				--
				-- You can add other tools here that you want Mason to install
				-- for you, so that they are available from within Neovim.
				local ensure_installed = vim.tbl_keys(servers or {})
				vim.list_extend(ensure_installed, {
					"stylua", -- Used to format Lua code
					"php-cs-fixer",
					-- "stylelint",
				})
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				require("mason-lspconfig").setup({
					ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
					automatic_installation = false,
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for ts_ls)
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		},
		{
			-- compatability plugin for linters and formatters
			"nvimtools/none-ls.nvim",
			opts = {},
		},
		{
			"jay-babu/mason-null-ls.nvim",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				"mason-org/mason.nvim",
				"nvimtools/none-ls.nvim",
			},
			config = function()
				require("mason").setup()
				require("mason-null-ls").setup({
					ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
					automatic_installation = false,
					handlers = {},
				})
			end,
		},
		{ -- Autoformat
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>cf",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[C]ode [F]ormat buffer",
				},
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "Code [F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				-- format_on_save = function(bufnr)
				-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
				-- 	-- have a well standardized coding style. You can add additional
				-- 	-- languages here or re-enable it for the disabled ones.
				-- 	local disable_filetypes = { c = true, cpp = true }
				-- 	local lsp_format_opt
				-- 	if disable_filetypes[vim.bo[bufnr].filetype] then
				-- 		lsp_format_opt = "never"
				-- 	else
				-- 		lsp_format_opt = "fallback"
				-- 	end
				-- 	return {
				-- 		timeout_ms = 500,
				-- 		lsp_format = lsp_format_opt,
				-- 	}
				-- end,
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},
		{ -- Autocompletion
			"saghen/blink.cmp",
			event = "VimEnter",
			version = "1.*",
			dependencies = {
				{
					"L3MON4D3/LuaSnip",
					version = "2.*",
					build = (function()
						-- Build Step is needed for regex support in snippets.
						-- This step is not supported in many windows environments.
						-- Remove the below condition to re-enable on windows.
						if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
							return
						end
						return "make install_jsregexp"
					end)(),
					dependencies = {
						-- `friendly-snippets` contains a variety of premade snippets.
						--    See the README about individual language/framework/plugin snippets:
						--    https://github.com/rafamadriz/friendly-snippets
						-- {
						--   'rafamadriz/friendly-snippets',
						--   config = function()
						--     require('luasnip.loaders.from_vscode').lazy_load()
						--   end,
						-- },
					},
					opts = {},
				},
				"folke/lazydev.nvim",
			},
			opts = {
				keymap = { preset = "default" },
				appearance = {
					nerd_font_variant = "mono",
				},
				completion = {
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
					},
					list = {
						selection = {
							preselect = false,
							auto_insert = false,
						},
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "lazydev", "buffer" },
					providers = {
						lazydev = {
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},
				snippets = { preset = "luasnip" },

				-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
				-- which automatically downloads a prebuilt binary when enabled.
				--
				-- By default, we use the Lua implementation instead, but you may enable
				-- the rust implementation via `'prefer_rust_with_warning'`
				--
				-- See :h blink-cmp-config-fuzzy for more information
				-- fuzzy = { implementation = "lua" },

				-- Shows a signature help window while you type arguments for a function
				signature = { enabled = true },
			},
			opts_extend = { "sources.default" },
		},
		-- { -- Autocompletion
		-- 	"hrsh7th/nvim-cmp",
		-- 	event = "InsertEnter",
		-- 	dependencies = {
		-- 		-- Snippet Engine & its associated nvim-cmp source
		-- 		{
		-- 			"L3MON4D3/LuaSnip",
		-- 			build = (function()
		-- 				-- Build Step is needed for regex support in snippets.
		-- 				-- This step is not supported in many windows environments.
		-- 				-- Remove the below condition to re-enable on windows.
		-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
		-- 					return
		-- 				end
		-- 				return "make install_jsregexp"
		-- 			end)(),
		-- 			dependencies = {
		-- 				-- `friendly-snippets` contains a variety of premade snippets.
		-- 				--    See the README about individual language/framework/plugin snippets:
		-- 				--    https://github.com/rafamadriz/friendly-snippets
		-- 				-- {
		-- 				--   'rafamadriz/friendly-snippets',
		-- 				--   config = function()
		-- 				--     require('luasnip.loaders.from_vscode').lazy_load()
		-- 				--   end,
		-- 				-- },
		-- 			},
		-- 		},
		-- 		"saadparwaiz1/cmp_luasnip",
		--
		-- 		-- Adds other completion capabilities.
		-- 		--  nvim-cmp does not ship with all sources by default. They are split
		-- 		--  into multiple repos for maintenance purposes.
		-- 		"hrsh7th/cmp-nvim-lsp",
		-- 		"hrsh7th/cmp-path",
		-- 	},
		-- 	config = function()
		-- 		-- See `:help cmp`
		-- 		local cmp = require("cmp")
		-- 		local luasnip = require("luasnip")
		-- 		luasnip.config.setup({})
		--
		-- 		cmp.setup({
		-- 			snippet = {
		-- 				expand = function(args)
		-- 					luasnip.lsp_expand(args.body)
		-- 				end,
		-- 			},
		-- 			completion = { completeopt = "menu,menuone,noselect,noinsert" },
		--
		-- 			-- For an understanding of why these mappings were
		-- 			-- chosen, you will need to read `:help ins-completion`
		-- 			--
		-- 			-- No, but seriously. Please read `:help ins-completion`, it is really good!
		-- 			mapping = cmp.mapping.preset.insert({
		-- 				-- Select the [n]ext item
		-- 				["<C-n>"] = cmp.mapping.select_next_item(),
		-- 				-- Select the [p]revious item
		-- 				["<C-p>"] = cmp.mapping.select_prev_item(),
		--
		-- 				-- Scroll the documentation window [b]ack / [f]orward
		-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
		-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
		--
		-- 				-- Accept ([y]es) the completion.
		-- 				--  This will auto-import if your LSP supports it.
		-- 				--  This will expand snippets if the LSP sent a snippet.
		-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
		--
		-- 				-- If you prefer more traditional completion keymaps,
		-- 				-- you can uncomment the following lines
		-- 				--['<CR>'] = cmp.mapping.confirm { select = true },
		-- 				--['<Tab>'] = cmp.mapping.select_next_item(),
		-- 				--['<S-Tab>'] = cmp.mapping.select_prev_item(),
		--
		-- 				-- Manually trigger a completion from nvim-cmp.
		-- 				--  Generally you don't need this, because nvim-cmp will display
		-- 				--  completions whenever it has completion options available.
		-- 				["<C-Space>"] = cmp.mapping.complete({}),
		--
		-- 				-- Think of <c-l> as moving to the right of your snippet expansion.
		-- 				--  So if you have a snippet that's like:
		-- 				--  function $name($args)
		-- 				--    $body
		-- 				--  end
		-- 				--
		-- 				-- <c-l> will move you to the right of each of the expansion locations.
		-- 				-- <c-h> is similar, except moving you backwards.
		-- 				["<C-l>"] = cmp.mapping(function()
		-- 					if luasnip.expand_or_locally_jumpable() then
		-- 						luasnip.expand_or_jump()
		-- 					end
		-- 				end, { "i", "s" }),
		-- 				["<C-h>"] = cmp.mapping(function()
		-- 					if luasnip.locally_jumpable(-1) then
		-- 						luasnip.jump(-1)
		-- 					end
		-- 				end, { "i", "s" }),
		--
		-- 				-- ["<A-y>"] = require('minuet').make_cmp_map(),
		--
		-- 				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		-- 				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
		-- 			}),
		-- 			sources = {
		-- 				-- Include minuet as a source to enable autocompletion
		-- 				-- { name = "minuet" },
		-- 				{
		-- 					name = "lazydev",
		-- 					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
		-- 					group_index = 0,
		-- 				},
		-- 				{ name = "nvim_lsp" },
		-- 				{ name = "luasnip" },
		-- 				{ name = "path" },
		-- 				{ name = "symfony_routes" },
		-- 				{ name = "symfony_translations" },
		-- 			},
		-- 		})
		-- 	end,
		-- },
		{
			"rose-pine/neovim",
			name = "rose-pine",
			dependencies = {
				"f-person/auto-dark-mode.nvim",
			},
			version = false,
			lazy = false,
			priority = 1000, -- make sure to load this before all the other start plugins
			config = function()
				require("auto-dark-mode").setup()

				-- set background and colorscheme
				-- vim.opt.background = "light"
				vim.cmd.colorscheme("rose-pine")
			end,
		},
		{ -- Highlight todo, notes, etc in comments
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		{ -- Collection of various small independent plugins/modules
			"echasnovski/mini.nvim",
			version = false,
			dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [']quote
				--  - ci'  - [C]hange [I]nside [']quote
				require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()
				require("mini.comment").setup({
					options = {
						custom_commentstring = function()
							if vim.bo.filetype == "twig" then
								return "{# %s #}"
							end
							return require("ts_context_commentstring.internal").calculate_commentstring()
								or vim.bo.commentstring
						end,
					},
				})
				require("mini.icons").setup()
				require("mini.indentscope").setup()
				-- ... and there is more!
				--  Check out: https://github.com/echasnovski/mini.nvim
			end,
		},
		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			-- branch = "main",
			lazy = false,
			build = ":TSUpdate",
			main = "nvim-treesitter.configs", -- Sets main module to use for opts
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
					"php",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = {
					enable = true,
					-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
					--  If you are experiencing weird indenting issues, add the language to
					--  the list of additional_vim_regex_highlighting and disabled languages for indent.
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			},
			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		},
		-- { -- startup dashboard
		-- 	"goolord/alpha-nvim",
		-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
		-- 	config = function()
		-- 		--require'alpha'.setup(require'alpha.themes.dashboard'.config)
		-- 		require("alpha").setup(require("alphaConf").config)
		-- 	end,
		-- },
		{ -- Set lualine as statusline
			"nvim-lualine/lualine.nvim",
			opts = {
				options = {
					theme = "auto",
					icons_enabled = vim.g.have_nerd_font,
					component_separators = "|",
					section_separators = "",
				},
			},
		},
		{
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
								icon = " ",
								key = "f",
								desc = "Find File",
								action = ":lua Snacks.dashboard.pick('files')",
							},
							{
								icon = " ",
								key = "g",
								desc = "Find Text",
								action = ":lua Snacks.dashboard.pick('live_grep')",
							},
							{
								icon = " ",
								key = "r",
								desc = "Recent Files",
								action = ":lua Snacks.dashboard.pick('oldfiles')",
							},
							{
								icon = " ",
								key = "c",
								desc = "Config",
								action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
							},
							{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
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
							{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
						},
					},
					sections = {
						{ section = "header" },
						{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
						{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
						{ section = "startup" },
					},
				},
				explorer = { enabled = true },
				lazygit = { enabled = true },
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
		},
		-- { -- splits navigation & management
		-- 	"mrjones2014/smart-splits.nvim",
		-- 	config = function()
		-- 		local smspl = require("smart-splits")
		-- 		smspl.setup({
		-- 			ignored_buftypes = { "neo-tree", "dbui" },
		-- 		})
		--
		-- 		require("which-key").add({
		-- 			{ "<leader><leader>", name = "Smart Splits Swap Buffer" },
		-- 		})
		--
		-- 		vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize split left" })
		-- 		vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize split down" })
		-- 		vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize split up" })
		-- 		vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize split right" })
		-- 		-- moving between splits
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<C-h>",
		-- 			require("smart-splits").move_cursor_left,
		-- 			{ desc = "Move cursor a split left" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<C-j>",
		-- 			require("smart-splits").move_cursor_down,
		-- 			{ desc = "Move cursor a split below" }
		-- 		)
		-- 		vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move cursor a split above" })
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<C-l>",
		-- 			require("smart-splits").move_cursor_right,
		-- 			{ desc = "Move cursor a split right" }
		-- 		)
		-- 		-- swapping buffers between windows
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader><leader>h",
		-- 			require("smart-splits").swap_buf_left,
		-- 			{ desc = "Swap with left Buffer" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader><leader>j",
		-- 			require("smart-splits").swap_buf_down,
		-- 			{ desc = "Swap with Buffer below" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader><leader>k",
		-- 			require("smart-splits").swap_buf_up,
		-- 			{ desc = "Swap with Buffer above" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader><leader>l",
		-- 			require("smart-splits").swap_buf_right,
		-- 			{ desc = "Swap with right Buffer" }
		-- 		)
		-- 	end,
		-- },
		{ "vuciv/golf" },
		"mbbill/undotree",
		-- {
		-- 	"mfussenegger/nvim-dap",
		-- 	dependencies = { "xdebug/vscode-php-debug", "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
		-- 	config = function()
		-- 		local dap = require("dap")
		-- 		dap.adapters.php = {
		-- 			type = "executable",
		-- 			command = "node",
		-- 			args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
		-- 		}
		--
		-- 		dap.configurations.php = {
		-- 			{
		-- 				type = "php",
		-- 				request = "launch",
		-- 				name = "Listen for Xdebug",
		-- 				port = 9003,
		-- 			},
		-- 		}
		-- 	end,
		-- 	keys = {
		-- 		{
		-- 			"<leader>db",
		-- 			function()
		-- 				require("dap").toggle_breakpoint()
		-- 			end,
		-- 			desc = "Toggle Breakpoint",
		-- 		},
		-- 		{
		-- 			"<leader>dc",
		-- 			function()
		-- 				require("dap").continue()
		-- 			end,
		-- 			desc = "Continue",
		-- 		},
		-- 		{
		-- 			"<leader>dT",
		-- 			function()
		-- 				require("dap").terminate()
		-- 			end,
		-- 			desc = "Terminate",
		-- 		},
		-- 	},
		-- },
		{
			"gh-liu/fold_line.nvim",
			event = "VeryLazy",
			init = function()
				-- change the char of the line, see the `Appearance` section
				vim.g.fold_line_char_open_start = "╭"
				vim.g.fold_line_char_open_end = "╰"
			end,
		},
		{
			"tpope/vim-abolish",
			keys = {
				{ "cru", desc = "Coerce to UPPER_CASE", mode = "n" },
				{ "crs", desc = "Coerce to snake_case", mode = "n" },
				{ "crm", desc = "Coerce to MixedCase", mode = "n" },
				{ "crc", desc = "Coerce to camelCase", mode = "n" },
				{ "cr-", desc = "Coerce to dash-case", mode = "n" },
				{ "cr.", desc = "Coerce to dot.case", mode = "n" },
			},
			opts = function()
				require("which-key").add({})
			end,
		},
	},
	checker = { enabled = true },
	install = { colorscheme = { "catppuccin-latte" } },
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et
