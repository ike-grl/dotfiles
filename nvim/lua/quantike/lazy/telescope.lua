return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build='make' },
        "debugloop/telescope-undo.nvim",
    },
    config = function()
        require('telescope').setup({
            extensions = {
                fzf = {},
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                }
            }
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("undo")

        local builtin = require('telescope.builtin')

        -- <leader>pu -> Searches undo history
        vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

        -- <leader>pf -> Searches for a file in the current directory
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

        -- <C-p> -> Searches current directory for hidden files
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        -- <leader>pg -> Searches current directory via live grep
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})

        -- <leader>pws -> Searches for the current word selection across current directory
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        -- <leader>pWs -> Searches exactly for the current word selection across current directory
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        -- <leader>ps -> Searches via grep in current directory
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        -- <leader>ph -> Searches for help tags
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})

        -- <leader>pn -> Searches the ~/.nvim directory (useful for editing your neovim config)
        vim.keymap.set('n', '<leader>pn', function()
            builtin.find_files {
                cmd = vim.fn.stdpath("config")
            }
        end)
    end
}
