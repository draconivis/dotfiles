-- Load core configuration
require("options")
require("keymaps")

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    -- No setup needed
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/mbbill/undotree",
    "https://github.com/tpope/vim-abolish",

    -- Colorscheme
    "https://github.com/f-person/auto-dark-mode.nvim",
    "https://github.com/rose-pine/neovim",

    -- UI
    "https://github.com/folke/which-key.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/folke/todo-comments.nvim",

    -- Editing
    "https://github.com/saghen/blink.cmp",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/NMAC427/guess-indent.nvim",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    "https://github.com/nvim-mini/mini.nvim",

    -- LSP
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/neovim/nvim-lspconfig",

    -- Treesitter
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

-- =============================================================================
-- Colorscheme
-- =============================================================================

require("auto-dark-mode").setup()
vim.cmd.colorscheme("rose-pine")

-- =============================================================================
-- which-key
-- =============================================================================

require("which-key").setup({
    delay = 0,
    icons = {
        mappings = vim.g.have_nerd_font,
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
    spec = {
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>g", group = "[G]it", mode = { "n", "x" } },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
    },
})

-- =============================================================================
-- Snacks
-- =============================================================================

require("snacks").setup({
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

-- lazygit
vim.keymap.set("n", "<leader>lg", function()
    Snacks.lazygit()
end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gf", function()
    Snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })
-- git
vim.keymap.set("n", "<leader>gb", function()
    Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>go", function()
    Snacks.gitbrowse.open()
end, { desc = "Git Browse" })
-- file explorer
vim.keymap.set("n", "<leader>n", function()
    Snacks.explorer()
end, { desc = "File Explorer" })
-- picker
vim.keymap.set("n", "<leader>sf", function()
    Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>sF", function()
    Snacks.picker.files({ hidden = true, ignored = true })
end, { desc = "Find Files (all)" })
vim.keymap.set("n", "<leader>sg", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>sG", function()
    Snacks.picker.grep({ hidden = true, ignored = true })
end, { desc = "Grep (all)" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
vim.keymap.set({ "n", "x" }, "<leader>sW", function()
    Snacks.picker.grep_word({ hidden = true, ignored = true })
end, { desc = "Visual selection or word (all)" })
vim.keymap.set("n", "<leader>s.", function()
    Snacks.picker.recent()
end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>:", function()
    Snacks.picker.command_history()
end, { desc = "Command History" })
vim.keymap.set("n", '<leader>s"', function()
    Snacks.picker.registers()
end, { desc = "Registers" })
vim.keymap.set("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>si", function()
    Snacks.picker.icons()
end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sr", function()
    Snacks.picker.resume()
end, { desc = "Resume" })
-- LSP via picker
vim.keymap.set("n", "grd", function()
    Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set("n", "grD", function()
    Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set("n", "grr", function()
    Snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })
vim.keymap.set("n", "grI", function()
    Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

-- =============================================================================
-- todo-comments
-- =============================================================================

require("todo-comments").setup({ signs = false })

-- =============================================================================
-- blink.cmp
-- =============================================================================

require("blink.cmp").setup({
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
        default = { "lsp", "path", "snippets", "buffer" },
    },
    signature = { enabled = true },
})

-- =============================================================================
-- conform
-- =============================================================================

require("conform").setup({
    notify_on_error = false,
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "php_cs_fixer" },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[C]ode [F]ormat buffer" })
vim.keymap.set({ "n", "v" }, "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Code [F]ormat buffer" })

-- =============================================================================
-- gitsigns
-- =============================================================================

require("gitsigns").setup({
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
        vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
    end,
})

-- =============================================================================
-- guess-indent
-- =============================================================================

require("guess-indent").setup({})

-- =============================================================================
-- mini.nvim
-- =============================================================================

-- Better Around/Inside textobjects
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [']quote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--  - sd'   - [S]urround [D]elete [']quotes
--  - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

require("ts_context_commentstring").setup({ enable_autocmd = false })
require("mini.comment").setup({
    options = {
        custom_commentstring = function()
            if vim.bo.filetype == "twig" then
                return "{# %s #}"
            end
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
    },
})
require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.statusline").setup()

-- =============================================================================
-- LSP
-- =============================================================================

require("mason").setup()
require("fidget").setup({})

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
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
    twiggy_language_server = {},
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

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua",
    "php-cs-fixer",
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

-- =============================================================================
-- Treesitter
-- =============================================================================

require("nvim-treesitter").install({
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
})

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then
        return
    end
    vim.treesitter.start(buf, language)

    local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
    if has_indent_query then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
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
            treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
            require("nvim-treesitter").install(language):await(function()
                treesitter_try_attach(buf, language)
            end)
        else
            treesitter_try_attach(buf, language)
        end
    end,
})
