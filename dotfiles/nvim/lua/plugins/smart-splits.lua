return {

	{ -- splits navigation & management
		"mrjones2014/smart-splits.nvim",
		config = function()
			local smspl = require("smart-splits")
			smspl.setup({
				ignored_buftypes = { "neo-tree", "dbui" },
			})

			require("which-key").register({
				["<leader><leader>"] = { name = "Smart Splits Swap Buffer", _ = "which_key_ignore" },
			})

			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize split left" })
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize split down" })
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize split up" })
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize split right" })
			-- moving between splits
			vim.keymap.set(
				"n",
				"<C-h>",
				require("smart-splits").move_cursor_left,
				{ desc = "Move cursor a split left" }
			)
			vim.keymap.set(
				"n",
				"<C-j>",
				require("smart-splits").move_cursor_down,
				{ desc = "Move cursor a split below" }
			)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move cursor a split above" })
			vim.keymap.set(
				"n",
				"<C-l>",
				require("smart-splits").move_cursor_right,
				{ desc = "Move cursor a split right" }
			)
			-- swapping buffers between windows
			vim.keymap.set(
				"n",
				"<leader><leader>h",
				require("smart-splits").swap_buf_left,
				{ desc = "Swap with left Buffer" }
			)
			vim.keymap.set(
				"n",
				"<leader><leader>j",
				require("smart-splits").swap_buf_down,
				{ desc = "Swap with Buffer below" }
			)
			vim.keymap.set(
				"n",
				"<leader><leader>k",
				require("smart-splits").swap_buf_up,
				{ desc = "Swap with Buffer above" }
			)
			vim.keymap.set(
				"n",
				"<leader><leader>l",
				require("smart-splits").swap_buf_right,
				{ desc = "Swap with right Buffer" }
			)
		end,
	},
}
-- vim: set ts=2 sw=2 tw=0 noet
