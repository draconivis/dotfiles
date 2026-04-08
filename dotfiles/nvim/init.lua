-- [[ Basic Config ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.rtp:append("/opt/homebrew/bin/fzf")
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    virtual_text = true,
    virtual_lines = false,
    jump = { float = true },
})

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite current buffer" })
vim.keymap.set("n", "<leader>a", "<cmd>wa<CR>", { desc = "[W]rite [a]ll buffers" })
vim.keymap.set("n", "<TAB>", "<C-^>", { desc = "Alternate buffers" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current Line Up" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'update' or kind == 'install') then
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        vim.cmd('TSUpdate')
    end
end })

-- [[ Basic Commands ]]
vim.api.nvim_create_user_command("Wa", function()
    vim.cmd("wa")
end, {})
vim.api.nvim_create_user_command("Wqa", function()
    vim.cmd("wqa")
end, {})


-- [[ Plugins ]]
vim.pack.add({
'https://github.com/lewis6991/gitsigns.nvim',
'https://github.com/folke/which-key.nvim',
	'https://github.com/folke/snacks.nvim',

    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/NMAC427/guess-indent.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    'https://github.com/f-person/auto-dark-mode.nvim',
    'https://github.com/folke/todo-comments.nvim',
    'https://github.com/j-hui/fidget.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mbbill/undotree',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/rose-pine/neovim',
    'https://github.com/saghen/blink.cmp',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/tpope/vim-abolish',
})

-- [[ Plugin Configuration ]]

-- gitsigns
require('gitsigns').setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr, desc = "View diff" })
        vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
    end,
})

-- which-key
require('which-key').setup({
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
        { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "gr", group = "LSP Actions", mode = { "n" } },
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>g", group = "[G]it", mode = { "n", "x" } },
        { "<leader>r", group = "[R]ename" },
        { "<leader>l", group = "[L]azy..." },
    },
})

-- snacks
require('snacks').setup({
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
})

vim.keymap.set("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "[L]azy[g]it" })
vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>go", function() Snacks.gitbrowse.open() end, { desc = "Git Open File in Repository" })
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>sG", function() Snacks.picker.grep({ hidden = true, ignored = true }) end, { desc = "Grep w/ hidden" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function() Snacks.explorer() end, { desc = "File Explorer" })
vim.keymap.set("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>sF", function() Snacks.picker.files({ hidden = true, ignored = true }) end, { desc = "Find Files w/ hidden" })
vim.keymap.set("n", "<leader>s.", function() Snacks.picker.recent() end, { desc = "Recent files" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Grep selection or word" })
vim.keymap.set({ "n", "x" }, "<leader>sW", function() Snacks.picker.grep_word({ hidden = true, ignored = true }) end, { desc = "Grep selection or word " })
vim.keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
-- vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
-- vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sr", function() Snacks.picker.resume() end, { desc = "Resume last search" })
vim.keymap.set("n", "grd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "grD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "grI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight", event.buf) then
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

        if client and client:supports_method("textDocument/inlayHint", event.buf) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})

local servers = {
    twiggy_language_server = {},
    phpactor = {},
    stylua = {},
    lua_ls = {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
                    return
                end
            end
            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
                workspace = {
                    checkThirdParty = false,
                    library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
                        "${3rd}/luv/library",
                        "${3rd}/busted/library",
                    }),
                },
            })
        end,
    },
}

require("mason").setup()
require("mason-lspconfig").setup()
local ensure_installed = vim.tbl_keys(servers)
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
end

-- conform
require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
        else
            return { timeout_ms = 500, lsp_format = "fallback" }
        end
    end,
    formatters_by_ft = {
        lua = { "stylua" },
    },
})

vim.keymap.set("", "<leader>f", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, { desc = "[F]ormat buffer" })

-- blink.cmp
require('blink.cmp').setup({
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        list = { selection = { preselect = false, auto_insert = false } },
    },
    sources = { default = { "lsp", "path", "snippets" } },
    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
})

-- colorscheme
require('auto-dark-mode').setup()
vim.cmd.colorscheme('rose-pine')

-- todo-comments
require('todo-comments').setup({ signs = false })

-- mini.nvim
require('mini.ai').setup({ n_lines = 500 })
require('mini.surround').setup()
require('mini.comment').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()

local statusline = require('mini.statusline')
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function() return "%2l:%-2v" end

-- treesitter
local parsers = {
    "bash", "c", "css", "diff", "dockerfile", "fish", "git_config", "git_rebase",
    "gitcommit", "gitignore", "html", "javascript", "jsdoc", "json", "lua", "luadoc",
    "markdown", "markdown_inline", "php", "python", "twig", "query", "regex", "ruby",
    "sql", "toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
}
require('nvim-treesitter').install(parsers)

local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end
        local installed = require('nvim-treesitter').get_installed('parsers')
        if vim.tbl_contains(installed, language) then
            treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(require('nvim-treesitter').get_available(), language) then
            require('nvim-treesitter').install(language):await(function()
                treesitter_try_attach(buf, language)
            end)
        else
            treesitter_try_attach(buf, language)
        end
    end,
})

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "toggle [U]ndotree" })

-- vim-abolish
vim.keymap.set("n", "<leader>cru", ":Coerce UPPER_CASE<CR>", { desc = "Coerce to UPPER_CASE" })
vim.keymap.set("n", "<leader>crs", ":Coerce snake_case<CR>", { desc = "Coerce to snake_case" })
vim.keymap.set("n", "<leader>crm", ":Coerce MixedCase<CR>", { desc = "Coerce to MixedCase" })
vim.keymap.set("n", "<leader>crc", ":Coerce camelCase<CR>", { desc = "Coerce to camelCase" })
vim.keymap.set("n", "<leader>cr-", ":Coerce dash-case<CR>", { desc = "Coerce to dash-case" })
vim.keymap.set("n", "<leader>cr.", ":Coerce dot.case<CR>", { desc = "Coerce to dot.case" })
