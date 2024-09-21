return {
	"eddyekofo94/gruvbox-flat.nvim",
	priority = 1000,
	enabled = true,
	opts = {
		gruvbox_dark_float = true,
	},
	config = function()
		vim.cmd([[colorscheme gruvbox-flat]])
	end,
}
