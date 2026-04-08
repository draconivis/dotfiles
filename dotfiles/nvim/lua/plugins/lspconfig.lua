-- Main LSP Configuration
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim", opts = {} },

        -- Allows extra capabilities provided by blink.cmp
        "saghen/blink.cmp",
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
                map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
                then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end

                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

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
            -- 			licenceKey = "YOUR_LICENSE_KEY_HERE",
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

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",
            "php-cs-fixer",
            -- "stylelint",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_installation = false,
        })

        for name, server in pairs(servers) do
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end

        -- Phpactor utilities
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
