-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
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
}
