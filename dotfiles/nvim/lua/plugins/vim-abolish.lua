return {
	"tpope/vim-abolish",
	keys = {
		{ "cru", desc = "Coerce to UPPER_CASE", mode = "n" },
		{ "crs", desc = "Coerce to snake_case", mode = "n" },
		{ "crm", desc = "Coerce to MixedCase", mode = "n" },
		{ "crc", desc = "Coerce to camelCase", mode = "n" },
		{ "cr-", desc = "Coerce to dash-case", mode = "n" },
		{ "cr.", desc = "Coerce to dot.case", mode = "n" },
	},
	opts = function()
		require("which-key").add({})
	end,
}
