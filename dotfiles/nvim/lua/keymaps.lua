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
