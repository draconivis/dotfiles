-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
	config = function()
		local parsers = {
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
		}
		require("nvim-treesitter").install(parsers)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf, filetype = args.buf, args.match

				local language = vim.treesitter.language.get_lang(filetype)
				if not language then return end

				-- check if parser exists and load it
				if not vim.treesitter.language.add(language) then return end
				-- enables syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- enables treesitter based indentation (skip ruby — uses vim regex for indent)
				if filetype ~= "ruby" then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
