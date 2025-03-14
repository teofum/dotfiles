local theme = {
    normal = {
        a = { bg = vim.g.base_text, fg = vim.g.base_bg },
        b = { bg = vim.g.base_bg, fg = vim.g.base_text },
        c = { bg = vim.g.base_bg, fg = vim.g.base_text },
    },
    insert = {
        a = { bg = vim.g.xcode_pink, fg = vim.g.base_bg },
        b = { bg = vim.g.base_bg, fg = vim.g.base_text },
        c = { bg = vim.g.base_bg, fg = vim.g.base_text },
    },
    visual = {
        a = { bg = vim.g.xcode_purple_dark, fg = vim.g.base_bg },
        b = { bg = vim.g.base_bg, fg = vim.g.base_text },
        c = { bg = vim.g.base_bg, fg = vim.g.base_text },
    },
    replace = {
        a = { bg = vim.g.xcode_orange, fg = vim.g.base_bg },
        b = { bg = vim.g.base_bg, fg = vim.g.base_text },
        c = { bg = vim.g.base_bg, fg = vim.g.base_text },
    },
    command = {
        a = { bg = vim.g.xcode_teal, fg = vim.g.base_bg },
        b = { bg = vim.g.base_bg, fg = vim.g.base_text },
        c = { bg = vim.g.base_bg, fg = vim.g.base_text },
    },
    inactive = {
        a = { bg = vim.g.base_bg, fg = vim.g.dark_text },
        b = { bg = vim.g.base_bg, fg = vim.g.dark_text },
        c = { bg = vim.g.base_bg, fg = vim.g.dark_text },
    },
}

return {
    "nvim-lualine/lualine.nvim",
    opts = {
        options = {
            icons_enabled = false,
            theme = theme,
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "▓▒░", right = "░▒▓" },
        }
    },
}
