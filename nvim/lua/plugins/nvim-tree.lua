return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local nvimtree = require("nvim-tree")

        -- Recommended settings from plugin
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = { width = 40 },
            renderer = {
                add_trailing = true,
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "├",
                        bottom = "─",
                        none = " ",
                    },
                    inline_arrows = false,
                },
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = false,
                    },
                    glyphs = {
                        folder = {
                            arrow_closed = "-",
                            arrow_open = "+",
                        },
                        git = {
                            unstaged = "-",
                            staged = "+",
                            unmerged = "↑",
                            renamed = "R",
                            untracked = "*",
                            deleted = "D",
                            ignored = "I",
                        },
                    },
                },
            },
            update_focused_file = {
                enable = true,
                update_root = { enable = true },
            },
            modified = { enable = true },
            actions = {
                file_popup = {
                    open_win_config = {
                        col = 1,
                        row = 1,
                        relative = "cursor",
                        border = "single",
                        style = "minimal",
                    }
                }
            },
        })

        -- Keybinds
        vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>")
        vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>")
        vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>")
        vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>")
    end
}
