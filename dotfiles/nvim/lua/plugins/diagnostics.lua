return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "tt", function()
				require("trouble").toggle()
			end, { desc = "[T]rouble [t]oggle" })
			-- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
			-- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
			vim.keymap.set("n", "tq", function()
				require("trouble").toggle("quickfix")
			end, { desc = "[T]rouble [q]uickfix" })
			-- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
			vim.keymap.set("n", "tl", function()
				require("trouble").toggle("lsp_references")
			end, { desc = "[T]rouble [l]sp reference" })
			require("which-key").register({
				["t"] = { name = "[T]rouble", _ = "which_key_ignore" },
				-- ["tt"] = { name = "[T]rouble [t]oggle", _ = "which_key_ignore" },
				-- ["tq"] = { name = "[T]rouble [q]uickfix", _ = "which_key_ignore" },
				-- ["tl"] = { name = "[T]rouble [l]sp reference", _ = "which_key_ignore" },
			})
		end,
		-- opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		-- },
	},
}
-- vim: set ts=2 sw=2 tw=0 noet
