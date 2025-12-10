return {
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
		-- vim.opt.background = "light"
		vim.cmd.colorscheme("rose-pine")
	end,
}
