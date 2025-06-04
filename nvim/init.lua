-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- vimopts
require("vimopts")

-- lazy.nvim setup
require("lazy").setup("plugins", {
	defaults = {
		lazy = false,
	},
})

-- treesitter config
local config = require("nvim-treesitter.configs")
config.setup({
	ensure_installed = {
		"go",
		"rust",
		"lua",
		"python",
		"zig",
		"sql",
		"markdown",
	},
	-- sql being slow on large files :(
	highlight = {
		enable = true,
	},
	indent = { enable = true },
	modules = {},
	sync_install = true,
	auto_install = true,
	ignore_install = {},
})

-- theme
vim.cmd("colorscheme gruvbox")
