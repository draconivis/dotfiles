-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	version = false,
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					if vim.bo.filetype == "twig" then
						return "{# %s #}"
					end
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		})
		require("mini.icons").setup()
		require("mini.indentscope").setup()
		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
