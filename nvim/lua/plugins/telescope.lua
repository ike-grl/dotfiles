return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require('telescope').setup {
              defaults = {
                -- global defaults here
              },
              pickers = {
                find_files = {
                  theme = "ivy",
                  -- any picker-specific overrides, e.g. previewer = false
                },
                live_grep = {
                  theme = "dropdown",
                  -- other opts...
                },
                diagnostics = {
                  theme = "cursor",
                  previewer = false
                },
                -- etc.
              },
              extensions = {
                fzf = {},
                ["ui-select"] = { require("telescope.themes").get_dropdown() },
              },
            }

			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>fds", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>fws", builtin.lsp_workspace_symbols, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- can add more here if needed
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
