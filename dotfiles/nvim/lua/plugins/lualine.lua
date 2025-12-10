-- Set lualine as statusline
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "auto",
			icons_enabled = vim.g.have_nerd_font,
			component_separators = "|",
			section_separators = "",
		},
	},
}
