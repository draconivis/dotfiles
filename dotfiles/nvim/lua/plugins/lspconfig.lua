-- Main LSP Configuration
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by blink.cmp
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
		--   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
		--   local diagnostic_signs = {}
		--   for type, icon in pairs(signs) do
		--     diagnostic_signs[vim.diagnostic.severity[type]] = icon
		--   end
		--   vim.diagnostic.config { signs = { text = diagnostic_signs } }
		-- end

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
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
			-- intelephense = {
			-- 	init_options = {
			-- 		licenceKey = "/Users/patrick/intelephense/license.txt",
			-- 	},
			-- 	settings = {
			-- 		intelephense = {
			-- 			licenceKey = "YOUR_LICENSE_KEY_HERE", -- Replace with your actual license key
			-- 		},
			-- 	},
			-- },
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

		-- requires plenary (which is required by telescope)
		local Float = require("plenary.window.float")

		vim.cmd([[
		  augroup Phpactor
		    autocmd!
		    autocmd Filetype php command! -nargs=0 PhpactorReindex lua vim.lsp.buf_notify(0, "phpactor/indexer/reindex",{})
		    autocmd Filetype php command! -nargs=0 PhpactorConfig lua PhpactorDumpConfig()
		    autocmd Filetype php command! -nargs=0 PhpactorStatus lua PhpactorStatus()
		    autocmd Filetype php command! -nargs=0 PhpactorBlackfireStart lua PhpactorBlackfireStart()
		    autocmd Filetype php command! -nargs=0 PhpactorBlackfireFinish lua PhpactorBlackfireFinish()
		  augroup END
		]])

		local function showWindow(title, syntax, contents)
			local out = {}
			for match in string.gmatch(contents, "[^\n]+") do
				table.insert(out, match)
			end

			local float = Float.percentage_range_window(0.6, 0.4, { winblend = 0 }, {
				title = title,
				topleft = "┌",
				topright = "┐",
				top = "─",
				left = "│",
				right = "│",
				botleft = "└",
				botright = "┘",
				bot = "─",
			})

			vim.api.nvim_buf_set_option(float.bufnr, "filetype", syntax)
			vim.api.nvim_buf_set_lines(float.bufnr, 0, -1, false, out)
		end

		function PhpactorDumpConfig()
			local results, _ = vim.lsp.buf_request_sync(0, "phpactor/debug/config", { ["return"] = true })
			for _, res in pairs(results or {}) do
				pcall(showWindow, "Phpactor LSP Configuration", "json", res["result"])
			end
		end
		function PhpactorStatus()
			local results, _ = vim.lsp.buf_request_sync(0, "phpactor/status", { ["return"] = true })
			for _, res in pairs(results or {}) do
				pcall(showWindow, "Phpactor Status", "markdown", res["result"])
			end
		end

		function PhpactorBlackfireStart()
			local _, _ = vim.lsp.buf_request_sync(0, "blackfire/start", {})
		end
		function PhpactorBlackfireFinish()
			local _, _ = vim.lsp.buf_request_sync(0, "blackfire/finish", {})
		end
	end,
}
