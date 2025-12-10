-- Compatability plugin for linters and formatters
return {
	{
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
}
