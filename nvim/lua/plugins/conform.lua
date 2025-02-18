return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "ruff" },
				rust = { "rustfmt" },
				-- go = { "gofumpt", "golines", "goimports-reviser" },
				yaml = { "yamlfmt" },
				json = { "prettier" },
			},
			{
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
