-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default & enable relative numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true
--- disable line breaks
-- vim.o.breakindent = false
-- vim.o.wrap = false

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- fzf
vim.opt.rtp:append("/opt/homebrew/bin/fzf")

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite current buffer" })
vim.keymap.set("n", "<leader>a", "<cmd>wa<CR>", { desc = "[W]rite [a]ll buffers" })

-- remap tab to c-6
vim.keymap.set("n", "<TAB>", "<C-^>", { desc = "Alternate buffers" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = { float = true },
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Move V-Lines up / down, by Primeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current Line Up" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- [[ Custom Commands ]]
vim.api.nvim_create_user_command("Wa", function()
    vim.cmd("wa")
end, {})
vim.api.nvim_create_user_command("Wqa", function()
    vim.cmd("wqa")
end, {})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
require("lazy").setup({
    { "NMAC427/guess-indent.nvim", opts = {} },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        ---@module 'gitsigns'
        ---@type Gitsigns.Config
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            signs = {
                add = { text = "+" }, ---@diagnostic disable-line: missing-fields
                change = { text = "~" }, ---@diagnostic disable-line: missing-fields
                delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
                topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
                changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr, desc = "View diff" })
                -- vim.keymap.set("n", "<leader>gsf", gitsigns.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
                vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
                vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
            end,
        },
    },
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter",
        ---@module 'which-key'
        ---@type wk.Opts
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            delay = 0,
            icons = { mappings = vim.g.have_nerd_font },

            -- Document existing key chains
            spec = {
                { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
                { "gr", group = "LSP Actions", mode = { "n" } },
                { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
                { "<leader>g", group = "[G]it", mode = { "n", "x" } },
                { "<leader>r", group = "[R]ename" },
                { "<leader>u", group = "[U]ndotree" },
                { "<leader>c", group = "[c]oerce (change casing)" },
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
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
    },

    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            {
                "mason-org/mason.nvim",
                ---@module 'mason.settings'
                ---@type MasonSettings
                ---@diagnostic disable-next-line: missing-fields
                opts = {},
            },
            -- Maps LSP server names between nvim-lspconfig and Mason package names.
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
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
                    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
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
                    if client and client:supports_method("textDocument/documentHighlight", event.buf) then
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
                                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client:supports_method("textDocument/inlayHint", event.buf) then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --  See `:help lsp-config` for information about keys and how to configure
            ---@type table<string, vim.lsp.Config>
            local servers = {
                twiggy_language_server = {},
                phpactor = {},
                stylua = {}, -- Used to format Lua code
                -- Special Lua Config, as recommended by neovim help docs
                lua_ls = {
                    on_init = function(client)
                        if client.workspace_folders then
                            local path = client.workspace_folders[1].name
                            if
                                path ~= vim.fn.stdpath("config")
                                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                            then
                                return
                            end
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                            runtime = {
                                version = "LuaJIT",
                                path = { "lua/?.lua", "lua/?/init.lua" },
                            },
                            workspace = {
                                checkThirdParty = false,
                                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                                library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
                                    "${3rd}/luv/library",
                                    "${3rd}/busted/library",
                                }),
                            },
                        })
                    end,
                    settings = {
                        Lua = {},
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
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                -- You can add other tools here that you want Mason to install
            })

            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            for name, server in pairs(servers) do
                vim.lsp.config(name, server)
                vim.lsp.enable(name)
            end
        end,
    },
    -- { -- Compatability plugin for linters and formatters
    --     {
    --         "nvimtools/none-ls.nvim",
    --         opts = {},
    --     },
    --     {
    --         "jay-babu/mason-null-ls.nvim",
    --         event = { "BufReadPre", "BufNewFile" },
    --         dependencies = {
    --             "mason-org/mason.nvim",
    --             "nvimtools/none-ls.nvim",
    --         },
    --         config = function()
    --             require("mason").setup()
    --             require("mason-null-ls").setup({
    --                 ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
    --                 automatic_installation = false,
    --                 handlers = {},
    --             })
    --         end,
    --     },
    -- },

    { -- Autoformat
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        ---@module 'conform'
        ---@type conform.setupOpts
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
                end
            end,
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
            -- Snippet Engine
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
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
            },
            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },
            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets" },
            },
            snippets = { preset = "luasnip" },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = { implementation = "lua" },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
        },
    },
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
            -- vim.o.background = "light"
            vim.cmd.colorscheme("rose-pine")
        end,
    },
    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        ---@module 'todo-comments'
        ---@type TodoOptions
        ---@diagnostic disable-next-line: missing-fields
        opts = { signs = false },
    },

    { -- Collection of various small independent plugins/modules
        "nvim-mini/mini.nvim",
        -- dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            -- require("ts_context_commentstring").setup({
            --     -- set commentstring depending on cursor location (useful for react)
            --     enable_autocmd = false,
            -- })

            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require("mini.statusline")
            -- set use_icons to true if you have a Nerd Font
            statusline.setup({ use_icons = vim.g.have_nerd_font })

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end

            require("mini.comment").setup(
                -- {
                --     options = {
                --         custom_commentstring = function()
                --             if vim.bo.filetype == "twig" then
                --                 return "{# %s #}"
                --             end
                --             return require("ts_context_commentstring.internal").calculate_commentstring()
                --                 or vim.bo.commentstring
                --         end,
                --     },
                --  }
            )
            require("mini.icons").setup()
            require("mini.indentscope").setup()
            -- ... and there is more!
            --  Check out: https://github.com/nvim-mini/mini.nvim
        end,
    },
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        branch = "main",
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
        config = function()
            -- ensure basic parser are installed
            local parsers = {
                "bash",
                "c",
                "css",
                "diff",
                "dockerfile",
                "fish",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "php",
                "python",
                "twig",
                "query",
                "regex",
                "ruby",
                "sql",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            }
            require("nvim-treesitter").install(parsers)

            ---@param buf integer
            ---@param language string
            local function treesitter_try_attach(buf, language)
                -- check if parser exists and load it
                if not vim.treesitter.language.add(language) then
                    return
                end
                -- enables syntax highlighting and other treesitter features
                vim.treesitter.start(buf, language)

                -- enables treesitter based folds
                -- for more info on folds see `:help folds`
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'

                -- enables treesitter based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

            local available_parsers = require("nvim-treesitter").get_available()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then
                        return
                    end

                    local installed_parsers = require("nvim-treesitter").get_installed("parsers")

                    if vim.tbl_contains(installed_parsers, language) then
                        -- enable the parser if it is installed
                        treesitter_try_attach(buf, language)
                    elseif vim.tbl_contains(available_parsers, language) then
                        -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
                        require("nvim-treesitter").install(language):await(function()
                            treesitter_try_attach(buf, language)
                        end)
                    else
                        -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                        treesitter_try_attach(buf, language)
                    end
                end,
            })
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "[U]ndotree [T]oggle" })
        end,
    },
    {
        "tpope/vim-abolish",
        keys = {
            { "<leader>cru", desc = "Coerce to UPPER_CASE", mode = "n" },
            { "<leader>crs", desc = "Coerce to snake_case", mode = "n" },
            { "<leader>crm", desc = "Coerce to MixedCase", mode = "n" },
            { "<leader>crc", desc = "Coerce to camelCase", mode = "n" },
            { "<leader>cr-", desc = "Coerce to dash-case", mode = "n" },
            { "<leader>cr.", desc = "Coerce to dot.case", mode = "n" },
        },
        opts = function()
            require("which-key").add({})
        end,
    },
    -- {
    --     "gh-liu/fold_line.nvim",
    --     event = "VeryLazy",
    --     init = function()
    --         -- change the char of the line, see the `Appearance` section
    --         vim.g.fold_line_char_open_start = "╭"
    --         vim.g.fold_line_char_open_end = "╰"
    --     end,
    -- },
    -- {
    --     "NMAC427/guess-indent.nvim",
    -- },
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     opts = {
    --         options = {
    --             theme = "auto",
    --             icons_enabled = vim.g.have_nerd_font,
    --             component_separators = "|",
    --             section_separators = "",
    --         },
    --     },
    -- },
}, { ---@diagnostic disable-line: missing-fields
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
