return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				file_ignore_patterns = {
					"^node_modules/",
				},
			},
		},
		keys = {
			{
				"<leader>sf",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"<leader>gf",
				function()
					require("telescope.builtin").git_files()
				end,
			},
			{
				"<leader>gd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").grep_string()
				end,
			},
			{
				"<leader>lg",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<leader>gr",
				function()
					require("telescope.builtin").lsp_references()
				end,
			},
			{
				"<leader>td",
				function()
					require("telescope.builtin").lsp_type_definitions()
				end,
			},
      {
        "<leader>sr",
        function()
          require("telescope.builtin").resume()
        end,
      },
		},
	},
}
